import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class ContainsPhotoUseCase {
  final MessageRepository repository;

  const ContainsPhotoUseCase(this.repository);

  Future<bool> call(String chatId, String messageId) async {
    return await repository.containsPhoto(chatId, messageId);
  }
}
