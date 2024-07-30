import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class DeleteMessageUseCase {
  final MessageRepository repository;

  const DeleteMessageUseCase(this.repository);

  Future<void> call(String chatId, String messageId) async {
    await repository.deleteMessage(chatId, messageId);
  }
}
