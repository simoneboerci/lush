import 'package:flutter/material.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/user_model.dart';

class ChatProvider with ChangeNotifier {
  ChatModel? _chat;
  List<UserModel> _participants = [];

  ChatModel? get chat => _chat;
  List<UserModel> get participants => _participants;

  Future<void> setChat(ChatModel chat) async {
    _chat = chat;
    _participants = [];
    notifyListeners();

    final userFetchTasks = chat.userIds.map((userId) async {
      final user = await FirebaseHelper.userHelper.getUserWithUid(userId);
      if (user != null) {
        return user;
      }
      return null;
    }).toList();

    final users = await Future.wait(userFetchTasks);
    _participants = users.whereType<UserModel>().toList();

    notifyListeners();
  }

  void clearChat() {
    _chat = null;
    _participants.clear();
    notifyListeners();
  }
}
