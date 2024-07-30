import 'package:lush_app/features/chat/domain/entities/message.dart';
import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';

class GetMessageByIdUseCase {
  final MessageRepository repository;

  const GetMessageByIdUseCase(this.repository);

  Future<Message?> call(String chatId, String messageId) async {
    return await repository.getMessageById(chatId, messageId);
  }
}
