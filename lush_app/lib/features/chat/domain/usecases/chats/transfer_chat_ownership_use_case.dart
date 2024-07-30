import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class TransferChatOwnershipUseCase {
  final ChatRepository repository;

  const TransferChatOwnershipUseCase(this.repository);

  Future<void> call(String chatId, String userId) async {
    await repository.trasferChatOwnership(chatId, userId);
  }
}
