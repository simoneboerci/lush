import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class ArchiveChatForUsersUseCase {
  final ChatRepository repository;

  const ArchiveChatForUsersUseCase(this.repository);

  Future<void> call(String chatId, List<String> userIds) async {
    await repository.archiveChatForUsers(chatId, userIds);
  }
}
