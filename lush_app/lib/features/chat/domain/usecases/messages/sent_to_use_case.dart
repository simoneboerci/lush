import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class SentToUseCase {
  final MessageRepository repository;

  const SentToUseCase(this.repository);

  Future<bool> call(String chatId, String messageId, String userId) async {
    return await repository.sentTo(chatId, messageId, userId);
  }
}
