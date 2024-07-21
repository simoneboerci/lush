import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/user_model.dart';
import 'package:lush_app/models/chat_provider_exception.dart';
import 'package:lush_app/models/message_model.dart';

class ChatProvider with ChangeNotifier {
  final IFirebaseHelper _firebaseHelper;

  ChatModel? _chat;
  List<UserModel> _participants = [];
  StreamSubscription<List<MessageModel>>? _chatSubscription;

  ChatProvider({required IFirebaseHelper firebaseHelper})
      : _firebaseHelper = firebaseHelper;

  ChatModel? get chat => _chat;
  List<UserModel> get participants => _participants;

  Future<void> setChat(ChatModel chat) async {
    await _cleanupPreviousChat();
    await _initializeChat(chat);
    await _setupChatListener(chat);
    await _fetchParticipants(chat);
  }

  Future<void> _cleanupPreviousChat() async {
    _chat = null;
    _participants.clear();
    await _chatSubscription?.cancel();
    notifyListeners();
  }

  Future<void> _initializeChat(ChatModel chat) async {
    _chat = chat;
    notifyListeners();
  }

  Future<void> _setupChatListener(ChatModel chat) async {
    _chatSubscription = FirebaseHelper()
        .chatsHelper
        .getMessagesFromChat(chat.id)
        .listen(_handleMessagesUpdate, onError: (error) {
      throw ChatProviderException('Error in chat stream');
    });
  }

  void _handleMessagesUpdate(List<MessageModel> updatedMessages) {
    if (_chat != null) {
      _chat = _chat!.copyWith(messages: updatedMessages);
      notifyListeners();
      markAllMessagesAsRead();
    }
  }

  Future<void> _fetchParticipants(ChatModel chat) async {
    try {
      final userFetchTasks = chat.userIds
          .map((userId) => _firebaseHelper.userHelper.getUserWithUid(userId))
          .toList();

      final users = await Future.wait(userFetchTasks);
      _participants = users.whereType<UserModel>().toList();
      notifyListeners();
    } catch (e) {
      throw ChatProviderException('Error fetching participants: $e');
    }
  }

  Future<void> markAllMessagesAsRead() async {
    if (_chat == null) return;

    final String currentUser = _firebaseHelper.userHelper.currentUserUid!;
    final updatedMessages = _updateMessageStatus(_chat!.messages, currentUser,
        MessageStatus.read, (status) => status != MessageStatus.read);

    await _updateMessagesInFirebase(updatedMessages, MessageStatus.read);
  }

  Future<void> markAllMessagesAsDelivered() async {
    if (_chat == null) return;

    final String currentUser = _firebaseHelper.userHelper.currentUserUid!;
    final updatedMessages = _updateMessageStatus(_chat!.messages, currentUser,
        MessageStatus.delivered, (status) => status == MessageStatus.sent);

    await _updateMessagesInFirebase(updatedMessages, MessageStatus.delivered);
  }

  List<MessageModel> _updateMessageStatus(
      List<MessageModel> messages,
      String currentUser,
      MessageStatus newStatus,
      bool Function(MessageStatus) condition) {
    return messages.map((message) {
      if (message.senderId != currentUser && condition(message.status)) {
        return message.copyWith(status: newStatus);
      }
      return message;
    }).toList();
  }

  Future<void> _updateMessagesInFirebase(
    List<MessageModel> messages,
    MessageStatus status,
  ) async {
    try {
      final updatedMessages =
          messages.where((m) => m.status == status).toList();
      if (updatedMessages.isNotEmpty) {
        await Future.wait(updatedMessages.map((message) =>
            _firebaseHelper.chatsHelper.updateMessage(_chat!.id, message)));
        _chat = _chat!.copyWith(messages: messages);
        notifyListeners();
      }
    } catch (e) {
      throw ChatProviderException('Error updating messages: $e');
    }
  }

  @override
  void dispose() {
    _chatSubscription?.cancel();
    super.dispose();
  }
}
