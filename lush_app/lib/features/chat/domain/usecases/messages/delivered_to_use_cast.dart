import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class DeliveredToUseCase {
  final MessageRepository repository;

  const DeliveredToUseCase(this.repository);

  Future<bool> call(String chatId, String messageId, String userId) async {
    return await repository.deliveredTo(chatId, messageId, userId);
  }
}
