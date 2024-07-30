import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';
import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class GetChatMessagesUseCase {
  final ChatRepository repository;

  const GetChatMessagesUseCase(this.repository);

  Future<Either<Failure, List<Message>>> call(String chatId) async {
    return await repository.getChatMessages(chatId);
  }
}
