import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class ShowMessageUseCase {
  final MessageRepository repository;

  const ShowMessageUseCase(this.repository);

  Future<void> call(
      String chatId, String messageId, List<String> userIds) async {
    repository.showMessageToUsers(chatId, messageId, userIds);
  }
}
