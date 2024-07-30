import 'package:lush_app/features/chat/domain/entities/message.dart';
import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  const SendMessageUseCase(this.repository);

  Future<void> call(String chatId, Message message) async {
    await repository.sendMessage(chatId, message);
  }
}
