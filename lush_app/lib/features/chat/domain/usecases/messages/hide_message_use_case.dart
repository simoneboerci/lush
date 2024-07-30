import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class HideMessageUseCase {
  final MessageRepository repository;

  const HideMessageUseCase(this.repository);

  Future<void> call(
      String chatId, String messageId, List<String> userIds) async {
    await repository.hideMessageFromUsers(chatId, messageId, userIds);
  }
}
