import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class ContainsVideoUseCase {
  final MessageRepository repository;

  const ContainsVideoUseCase(this.repository);

  Future<bool> call(String chatId, String messageId) async {
    return await repository.containsVideo(chatId, messageId);
  }
}
