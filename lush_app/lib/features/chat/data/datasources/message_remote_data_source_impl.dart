import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lush_app/core/constants/firebase_collections_labels.dart';
import 'package:lush_app/core/exceptions/message_remote_exceptions.dart';
import 'package:lush_app/features/chat/data/datasources/message_remote_data_source.dart';
import 'package:lush_app/features/chat/data/models/chat_model.dart';
import 'package:lush_app/features/chat/data/models/message_model.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final FirebaseFirestore _firestore;

  MessageRemoteDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _getChatRef(String chatId) {
    return _firestore.collection(FirebaseCollectionsLabels.chats).doc(chatId);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getChatSnapshot(
      String chatId) async {
    return await _firestore
        .collection(FirebaseCollectionsLabels.chats)
        .doc(chatId)
        .get();
  }

  @override
  Future<MessageModel?> getMessageById(String chatId, String messageId) async {
    try {
      final chatSnapshot = await _getChatSnapshot(chatId);

      if (!chatSnapshot.exists || chatSnapshot.data() == null) {
        MessageNotFoundException(chatId: chatId, messageId: messageId);
      }

      final messagesData = chatSnapshot.data()?[ChatModelField.messages.name]
              as List<dynamic>? ??
          [];

      final messageData = messagesData.firstWhere(
          (messageMap) => messageMap[MessageModelField.id.name] == messageId,
          orElse: () => throw MessageNotFoundException(
              chatId: chatId, messageId: messageId));

      return MessageModel.fromMap(messageData as Map<String, dynamic>);
    } catch (e) {
      MessageNotFoundException(chatId: chatId, messageId: messageId);
      return null;
    }
  }

  @override
  Future<void> sendMessage(String chatId, MessageModel message) async {
    try {
      final chatRef = _getChatRef(chatId);
      final messageData = message.toMap();
      final messageId =
          chatRef.collection(ChatModelField.messages.name).doc().id;

      messageData[MessageModelField.id.name] = messageId;
      messageData[MessageModelField.status.name] =
          MessageStatus.sent.toStringValue();

      await chatRef.update({
        ChatModelField.messages.name: FieldValue.arrayUnion([messageData]),
        //TODO: Rendi questo messaggio l'ultimo messaggio
      });
    } catch (e) {
      MessageSendFailedException(chatId: chatId, messageId: message.id);
    }
  }

  @override
  Future<void> deleteMessage(String chatId, String messageId) async {
    try {
      final chatRef = _getChatRef(chatId);
      final chatSnapshot = await chatRef.get();

      if (!chatSnapshot.exists && chatSnapshot.data() == null) {
        MessageNotFoundException(chatId: chatId, messageId: messageId);
      }

      final messagesData = chatSnapshot.data()?[ChatModelField.messages.name]
              as List<dynamic>? ??
          [];
      final messageData = messagesData
          .map((message) => message as Map<String, dynamic>)
          .firstWhere(
            (messageMap) => messageMap[MessageModelField.id.name] == messageId,
            orElse: () => throw MessageNotFoundException(
                chatId: chatId, messageId: messageId),
          );

      chatRef.update({
        ChatModelField.messages: FieldValue.arrayRemove([messageData]),
        //TODO: Aggiornare l'ultimo messaggio se quello rimosso era l'ultimo
      });
    } catch (e) {
      throw MessageDeleteFailedException(chatId: chatId, messageId: messageId);
    }
  }

  @override
  Future<void> addMessageToFavorite(
      String chatId, String messageId, String userId) async {
    try {
      final chatRef = _getChatRef(chatId);

      await _firestore.runTransaction((transaction) async {
        final chatSnapshot = await transaction.get(chatRef);

        if (!chatSnapshot.exists && chatSnapshot.data() == null) {
          MessageNotFoundException(chatId: chatId, messageId: messageId);
        }

        final messagesData = chatSnapshot.data()?[ChatModelField.messages.name]
                as List<dynamic>? ??
            [];

        final messageIndex = messagesData.indexWhere(
            (messageMap) => messageMap[MessageModelField.id.name] == messageId);

        if (messageIndex == -1) {
          throw MessageNotFoundException(chatId: chatId, messageId: messageId);
        }

        final messageData = messagesData[messageIndex];
        final messageModel = MessageModel.fromMap(messageData);

        messageModel.favoritesBy[userId] = true;

        final updatedMessagesData = [...messagesData];
        updatedMessagesData[messageIndex] = messageModel.toMap();

        transaction.update(chatRef, {
          ChatModelField.messages.name: updatedMessagesData,
          //TODO: Aggiorna l'ultimo messaggio se quello modificato è l'ultimo messaggio
        });
      });
    } catch (e) {
      throw MessageAddToFavoriteException(chatId: chatId, messageId: messageId);
    }
  }

  @override
  Future<void> removeMessageFromFavorite(
      String chatId, String messageId, String userId) async {
    final chatRef = _getChatRef(chatId);
    try {
      await _firestore.runTransaction((transaction) async {
        final chatSnapshot = await transaction.get(chatRef);

        if (!chatSnapshot.exists && chatSnapshot.data() == null) {
          MessageNotFoundException(chatId: chatId, messageId: messageId);
        }

        final messagesData = chatSnapshot.data()?[ChatModelField.messages.name]
                as List<dynamic>? ??
            [];

        final messageIndex = messagesData.indexWhere(
            (messageMap) => messageMap[MessageModelField.id.name] == messageId);

        if (messageIndex == -1) {
          throw MessageNotFoundException(chatId: chatId, messageId: messageId);
        }

        final messageData = messagesData[messageIndex];
        final messageModel = MessageModel.fromMap(messageData);

        messageModel.favoritesBy[userId] = false;

        final updatedMessagesData = [...messagesData];
        updatedMessagesData[messageIndex] = messageModel.toMap();

        transaction.update(chatRef, {
          ChatModelField.messages.name: updatedMessagesData,
          //TODO: Aggiorna l'ultimo messaggio se quello modificato è l'ultimo messaggio
        });
      });
    } catch (e) {
      throw MessageAddToFavoriteException(chatId: chatId, messageId: messageId);
    }
  }

  @override
  Future<bool> containsPhoto(String chatId, String messageId) async {
    MessageModel? message = await getMessageById(chatId, messageId);
    if (message == null) {
      throw MessageNotFoundException(chatId: chatId, messageId: messageId);
    }

    if (message.mediaUrl == null) return false;

    return message.mediaUrl!.isNotEmpty && message.mediaType == MediaType.image;
  }

  @override
  Future<bool> containsVideo(String chatId, String messageId) async {
    MessageModel? message = await getMessageById(chatId, messageId);
    if (message == null) {
      throw MessageNotFoundException(chatId: chatId, messageId: messageId);
    }

    if (message.mediaUrl == null) return false;

    return message.mediaUrl!.isNotEmpty && message.mediaType == MediaType.video;
  }

  @override
  Future<bool> deliveredTo(
      String chatId, String messageId, String userId) async {
    //TODO: implement deliveredTo
    throw UnimplementedError();
  }

  @override
  Future<bool> readBy(String chatId, String messageId, String userId) {
    //TODO: implement deliveredTo
    throw UnimplementedError();
  }

  @override
  Future<bool> favoriteBy(String chatId, String messageId, String userId) {
    // TODO: implement favoriteBy
    throw UnimplementedError();
  }

  @override
  Future<bool> repliedToMessage(String chatId, String messageId,
      {String? repliedMessageId}) async {
    MessageModel? message = await getMessageById(chatId, messageId);

    if (message == null) {
      throw MessageNotFoundException(chatId: chatId, messageId: messageId);
    }

    if (repliedMessageId != null) {
      return message.replyToMessageId == repliedMessageId;
    } else {
      return message.replyToMessageId != null;
    }
  }

  @override
  Future<bool> sentBy(String chatId, String messageId, String userId) async {
    MessageModel? message = await getMessageById(chatId, messageId);

    if (message == null) {
      throw MessageNotFoundException(chatId: chatId, messageId: messageId);
    }

    return message.senderId == userId;
  }

  @override
  Future<bool> sentTo(String chatId, String messageId, String userId) {
    // TODO: implement sentTo
    throw UnimplementedError();
  }

  @override
  Future<void> hideMessageFromUsers(
      String chatId, String messageId, List<String> userIds) {
    // TODO: implement hideMessageFromUsers
    throw UnimplementedError();
  }

  @override
  Future<void> showMessageToUsers(
      String chatId, String messageId, List<String> userIds) {
    // TODO: implement showMessageToUsers
    throw UnimplementedError();
  }
}
