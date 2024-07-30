import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class KickOutUsersFromChatUseCase {
  final ChatRepository repository;

  const KickOutUsersFromChatUseCase(this.repository);

  Future<void> call(String chatId, List<String> userIds) async {
    await repository.kickOutUsersFromChat(chatId, userIds);
  }
}
