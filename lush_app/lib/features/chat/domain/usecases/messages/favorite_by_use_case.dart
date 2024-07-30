import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class FavoriteByUseCase {
  final MessageRepository repository;

  const FavoriteByUseCase(this.repository);

  Future<bool> call(String chatId, String messageId, String userId) async {
    return await repository.favoriteBy(chatId, messageId, userId);
  }
}
