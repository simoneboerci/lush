import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class DeArchiveChatForUsersUseCase {
  final ChatRepository repository;

  const DeArchiveChatForUsersUseCase(this.repository);

  Future<void> call(String chatId, List<String> userIds) async {
    await repository.deArchiveChatForUsers(chatId, userIds);
  }
}
