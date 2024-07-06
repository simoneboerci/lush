import 'package:flutter/material.dart';
import 'package:lush_app/constants/images.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/services/chat_provider.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  void _onSearch(String query) {}

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<List<ChatModel>>(
              stream: FirebaseHelper.getUserChats('currentUserId'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  print('Errore: ${snapshot.error}');
                  return Center(
                    child: Text(
                        'Errore durante il recupero delle chats dal databse: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  print('NO data');
                  return const Center(
                    child: Text('Ancora nessuna chat da recuperare:'),
                  );
                }

                final chats = snapshot.data!;

                return Flexible(
                    child: ListView.builder(
                  reverse: true,
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .setChat(chats[index]);
                        Navigator.pushNamed(context, '/direct_screen');
                      },
                      leading: const CircleAvatar(
                        backgroundImage: cLushTokenIcon,
                      ),
                      title: Text(
                        chats[index].participantIds[1],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(chats[index].lastMessage),
                      subtitleTextStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      trailing: Text(
                        chats[index].lastMessageTimestamp != null
                            ? '${chats[index].lastMessageTimestamp?.hour.toString().padLeft(2, '0')}:${chats[index].lastMessageTimestamp?.hour.toString().padLeft(2, '0')}'
                            : '',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ));
              }),
          CustomTextField.small(
            controller: _searchController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Scrivi qualcosa nella barra di ricerca';
              }

              return null;
            },
            onChanged: _onSearch,
            hintText: 'Cerca',
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
