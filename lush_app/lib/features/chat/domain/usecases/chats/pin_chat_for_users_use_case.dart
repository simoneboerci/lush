import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class PinChatForUsersUseCase {
  final ChatRepository repository;

  const PinChatForUsersUseCase(this.repository);

  Future<void> call(String chatId, List<String> userIds) async {
    await repository.pinChatForUsers(chatId, userIds);
  }
}
