import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class CleanChatUseCase {
  final ChatRepository repository;

  const CleanChatUseCase(this.repository);

  Future<void> call(String chatId) async {
    await repository.cleanChat(chatId);
  }
}
