import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class RemoveChatFromFavoriteUseCase {
  final ChatRepository repository;

  const RemoveChatFromFavoriteUseCase(this.repository);

  Future<void> call(String chatId, List<String> userIds) async {
    await repository.removeChatFromFavorite(chatId, userIds);
  }
}
