import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class RemoveMessageFromFavoriteUseCase {
  final MessageRepository repository;

  const RemoveMessageFromFavoriteUseCase(this.repository);

  Future<void> call(String chatId, String messageId) async {
    await repository.removeMessageFromFavorite(chatId, messageId);
  }
}
