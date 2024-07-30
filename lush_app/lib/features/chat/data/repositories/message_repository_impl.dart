import 'package:lush_app/core/exceptions/message_remote_exceptions.dart';
import 'package:lush_app/features/chat/data/datasources/message_remote_data_source.dart';
import 'package:lush_app/features/chat/data/models/message_model.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';
import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepositoryImpl({required this.messageRemoteDataSource});

  @override
  Message toEntity(MessageModel model) {
    return Message(
      id: model.id,
      chatId: model.chatId,
      senderId: model.senderId,
      text: model.text,
      timestamp: model.timestamp,
      status: model.status,
      replyToMessageId: model.replyToMessageId,
      favoritesBy: model.favoritesBy,
      mediaUrl: model.mediaUrl,
      mediaType: model.mediaType,
    );
  }

  @override
  MessageModel toModel(Message entity) {
    return MessageModel(
      id: entity.id,
      chatId: entity.chatId,
      senderId: entity.senderId,
      text: entity.text,
      timestamp: entity.timestamp,
      status: entity.status,
      replyToMessageId: entity.replyToMessageId,
      favoritesBy: entity.favoritesBy,
      mediaUrl: entity.mediaUrl,
      mediaType: entity.mediaType,
    );
  }

  @override
  Future<bool> containsPhoto(String chatId, String messageId) async {
    return await messageRemoteDataSource.containsPhoto(chatId, messageId);
  }

  @override
  Future<bool> containsVideo(String chatId, String messageId) async {
    return await messageRemoteDataSource.containsVideo(chatId, messageId);
  }

  @override
  Future<bool> deliveredTo(
      String chatId, String messageId, String userId) async {
    return await messageRemoteDataSource.deliveredTo(chatId, messageId, userId);
  }

  @override
  Future<bool> favoriteBy(
      String chatId, String messageId, String userId) async {
    return await messageRemoteDataSource.favoriteBy(chatId, messageId, userId);
  }

  @override
  Future<Message?> getMessageById(String chatId, String messageId) async {
    final messageModel =
        await messageRemoteDataSource.getMessageById(chatId, messageId);

    if (messageModel == null) {
      throw MessageNotFoundException(messageId: messageId);
    }

    return toEntity(messageModel);
  }

  @override
  Future<bool> readBy(String chatId, String messageId, String userId) async {
    return await messageRemoteDataSource.readBy(chatId, messageId, userId);
  }

  @override
  Future<bool> repliedToMessage(String chatId, String messageId,
      {String? repliedMessageId}) async {
    return await messageRemoteDataSource.repliedToMessage(chatId, messageId,
        repliedMessageId: repliedMessageId);
  }

  @override
  Future<void> sendMessage(String chatId, Message message) async {
    final messageModel = toModel(message);
    await messageRemoteDataSource.sendMessage(chatId, messageModel);
  }

  @override
  Future<bool> sentBy(String chatId, String messageId, String userId) async {
    return await messageRemoteDataSource.sentBy(chatId, messageId, userId);
  }

  @override
  Future<bool> sentTo(String chatId, String messageId, String userId) async {
    return await messageRemoteDataSource.sentTo(chatId, messageId, userId);
  }

  @override
  Future<void> deleteMessage(String chatId, String messageId) async {
    await messageRemoteDataSource.deleteMessage(chatId, messageId);
  }

  @override
  Future<void> addMessageToFavorite(String chatId, String messageId) {
    // TODO: implement addToFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> hideMessageFromUsers(
      String chatId, String messageId, List<String> userIds) {
    // TODO: implement hideFromUsers
    throw UnimplementedError();
  }

  @override
  Future<void> removeMessageFromFavorite(String chatId, String messageId) {
    // TODO: implement removeFromFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> showMessageToUsers(
      String chatId, String messageId, List<String> userIds) {
    // TODO: implement showToUsers
    throw UnimplementedError();
  }
}
