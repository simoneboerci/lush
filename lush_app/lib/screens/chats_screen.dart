import 'dart:async';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/images.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/user_model.dart';

import 'package:lush_app/services/chat_provider.dart';
import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_text_field.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  ChatsScreenState createState() => ChatsScreenState();
}

class ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final StreamController<List<UserModel>> _searchStreamController =
      StreamController<List<UserModel>>();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearch);
  }

  void _onSearch() async {
    if (_searchController.text.isEmpty) {
      _searchStreamController.add([]);
      return;
    }

    try {
      final results = await FirebaseHelper.userHelper
          .getUsersByQuery(query: _searchController.text);
      _searchStreamController.add(results);
    } catch (e) {
      _searchStreamController.addError('Errore nella ricerca: $e');
    }
  }

  Future<void> _startNewChat(UserModel user) async {
    final currentUserId = FirebaseHelper.userHelper.getCurrentUserUid!;

    ChatModel chat = await FirebaseHelper.chatsHelper
        .createChatBetweenUsers(currentUserId, user.id);

    await Provider.of<ChatProvider>(context, listen: false).setChat(chat);

    Navigator.pushNamed(context, '/direct_screen');
  }

  Future<String?> _getUserName(String userId) async {
    final user = await FirebaseHelper.userHelper.getUserWithUid(userId);
    if (user != null) {
      return user.chatInfo.username;
    }

    return userId;
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    _searchStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StreamBuilder<List<ChatModel>>(
              stream: FirebaseHelper.chatsHelper
                  .getUserChats(FirebaseHelper.userHelper.getCurrentUserUid!),
              builder: (context, chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (chatSnapshot.hasError) {
                  return Center(child: Text('Errore: ${chatSnapshot.error}'));
                }

                final chats = chatSnapshot.data ?? [];

                return StreamBuilder<List<UserModel>>(
                  stream: _searchStreamController.stream,
                  builder: (context, searchSnapshot) {
                    final searchResults = searchSnapshot.data ?? [];

                    return ListView.builder(
                      reverse: true,
                      itemCount: _searchController.text.isEmpty
                          ? chats.length
                          : searchResults.length,
                      itemBuilder: (context, index) {
                        if (_searchController.text.isEmpty) {
                          final chat = chats[index];
                          final otherUserId = chat.userIds.firstWhere(
                              (id) =>
                                  id !=
                                  FirebaseHelper.userHelper.getCurrentUserUid,
                              orElse: () => 'Utente sconosciuto');
                          return FutureBuilder(
                            future: _getUserName(otherUserId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: cLushTokenIcon,
                                  ),
                                  title: Text(
                                    'Caricamento...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }

                              if (snapshot.hasError || !snapshot.hasData) {
                                return const ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: cLushTokenIcon,
                                  ),
                                  title: Text(
                                    'Nome non disponibile',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }

                              final username = snapshot.data!;

                              return ListTile(
                                onTap: () async {
                                  await Provider.of<ChatProvider>(context,
                                          listen: false)
                                      .setChat(chat);
                                  Navigator.pushNamed(
                                      context, '/direct_screen');
                                },
                                leading: const CircleAvatar(
                                  backgroundImage: cLushTokenIcon,
                                ),
                                title: Text(
                                  username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: chat.lastMessage != null
                                    ? Text(
                                        chat.lastMessage!.text,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )
                                    : null,
                                subtitleTextStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                trailing: chat.lastMessage != null
                                    ? Text(
                                        '${chat.lastMessage!.timestamp.hour.toString().padLeft(2, '0')}:${chat.lastMessage!.timestamp.minute.toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    : null,
                              );
                            },
                          );
                        } else {
                          final user = searchResults[index];
                          return ListTile(
                            onTap: () => _startNewChat(user),
                            leading: const CircleAvatar(
                              backgroundImage: cLushTokenIcon,
                            ),
                            title: Text(
                              user.chatInfo.username ?? 'No username',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          CustomTextField.small(
            controller: _searchController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Scrivi qualcosa nella barra di ricerca';
              }
              return null;
            },
            hintText: 'Cerca',
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
