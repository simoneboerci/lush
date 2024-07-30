import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class ReadByUseCase {
  final MessageRepository repository;

  const ReadByUseCase(this.repository);

  Future<bool> call(String chatId, String messageId, String userId) async {
    return await repository.readBy(chatId, messageId, userId);
  }
}
