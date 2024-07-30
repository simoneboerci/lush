import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class RepliedToMessageUseCase {
  final MessageRepository repository;

  const RepliedToMessageUseCase(this.repository);

  Future<bool> call(String chatId, String messageId,
      {String? repliedMessageId}) async {
    return await repository.repliedToMessage(chatId, messageId,
        repliedMessageId: repliedMessageId);
  }
}
