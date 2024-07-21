import 'dart:async';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/images.dart';
import 'package:lush_app/constants/routes.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/user_model.dart';

import 'package:lush_app/services/chat_provider.dart';
import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:lush_app/widgets/contact_list_tile_widget.dart';

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
      final results = await FirebaseHelper()
          .userHelper
          .getUsersByQuery(_searchController.text);
      _searchStreamController.add(results);
    } catch (e) {
      _searchStreamController.addError('Errore nella ricerca: $e');
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    _searchStreamController.close();
    super.dispose();
  }

  void _onExistingChatPressed(BuildContext context, ChatModel chat) {
    context
        .read<ChatProvider>()
        .setChat(chat)
        .then((_) => _goToDirectScreen(context));
  }

  void _onNewChatPressed(BuildContext context, UserModel user) {
    final currentUserId = FirebaseHelper().userHelper.currentUserUid!;

    FirebaseHelper()
        .chatsHelper
        .createChatBetweenUsers(currentUserId, user.id)
        .then((chat) => context.read<ChatProvider>().setChat(chat))
        .then((_) => _goToDirectScreen(context));
  }

  void _goToDirectScreen(BuildContext context) =>
      Navigator.pushNamed(context, cDirectScreen);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildChatList()),
          _buildSearchField(),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return StreamBuilder(
      stream: FirebaseHelper()
          .chatsHelper
          .getUserChats(FirebaseHelper().userHelper.currentUserUid!),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
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
                  return _buildChatListItem(context, chats[index]);
                } else {
                  return _buildSearchResultItem(context, searchResults[index]);
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _buildChatListItem(BuildContext context, ChatModel chat) {
    final otherUserId = chat.userIds.firstWhere(
        (id) => id != FirebaseHelper().userHelper.currentUserUid,
        orElse: () => 'Utente sconosciuto');

    return FutureBuilder<UserModel?>(
      future: FirebaseHelper().userHelper.getUserWithUid(otherUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            leading: CircleAvatar(
              backgroundImage: cLushTokenIcon,
            ),
            title: Text(
              'Caricamento...',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: cLushTokenIcon,
            ),
            title: Text(
              'Errore: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        final user = snapshot.data!;

        return ContactListTileWidget(
          chat: chat,
          currentUserId: FirebaseHelper().userHelper.currentUserUid!,
          onTap: () => _onExistingChatPressed(context, chat),
        );
      },
    );
  }

  Widget _buildSearchResultItem(BuildContext context, UserModel user) {
    return ListTile(
      onTap: () => _onNewChatPressed(context, user),
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

  Widget _buildSearchField() {
    return CustomTextField.small(
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
    );
  }
}
