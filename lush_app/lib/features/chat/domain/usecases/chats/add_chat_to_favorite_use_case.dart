import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class AddChatToFavoriteUseCase {
  final ChatRepository repository;

  const AddChatToFavoriteUseCase(this.repository);

  Future<void> call(String chatId, List<String> userIds) async {
    await repository.addChatToFavorite(chatId, userIds);
  }
}
