import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class DeleteChatUseCase {
  final ChatRepository repository;

  const DeleteChatUseCase(this.repository);

  Future<void> call(String chatId) async {
    await repository.deleteChat(chatId);
  }
}
