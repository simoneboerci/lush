import 'package:lush_app/features/chat/data/models/message_model.dart';

abstract class MessageRemoteDataSource {
  Future<MessageModel?> getMessageById(String chatId, String messageId);

  Future<void> sendMessage(String chatId, MessageModel message);

  Future<void> hideMessageFromUsers(
      String chatId, String messageId, List<String> userIds);
  Future<void> showMessageToUsers(
      String chatId, String messageId, List<String> userIds);

  Future<void> addMessageToFavorite(
      String chatId, String messageId, String userId);
  Future<void> removeMessageFromFavorite(
      String chatId, String messageId, String userId);

  Future<void> deleteMessage(String chatId, String messageId);

  Future<bool> sentBy(String chatId, String messageId, String userId);
  Future<bool> sentTo(String chatId, String messageId, String userId);
  Future<bool> deliveredTo(String chatId, String messageId, String userId);
  Future<bool> readBy(String chatId, String messageId, String userId);

  Future<bool> favoriteBy(String chatId, String messageId, String userId);

  Future<bool> repliedToMessage(String chatId, String messageId,
      {String? repliedMessageId});

  Future<bool> containsPhoto(String chatId, String messageId);
  Future<bool> containsVideo(String chatId, String messageId);
}
