import 'package:flutter/material.dart';

import 'package:lush_app/models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  ChatModel? _chat;

  ChatModel? get chat => _chat;

  void setChat(ChatModel chat) {
    _chat = chat;
    notifyListeners();
  }

  void clearChat() {
    _chat = null;
    notifyListeners();
  }
}
