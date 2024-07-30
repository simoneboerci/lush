import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class UnpinChatForUsersUseCase {
  final ChatRepository repository;

  const UnpinChatForUsersUseCase(this.repository);

  Future<void> call(String chatId, List<String> userIds) async {
    await repository.unpinChatForUsers(chatId, userIds);
  }
}
