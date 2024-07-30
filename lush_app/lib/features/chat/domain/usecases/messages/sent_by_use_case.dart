import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class SentByUseCase {
  final MessageRepository repository;

  const SentByUseCase(this.repository);

  Future<bool> call(String chatId, String messageId, String userId) async {
    return await repository.sentBy(chatId, messageId, userId);
  }
}
