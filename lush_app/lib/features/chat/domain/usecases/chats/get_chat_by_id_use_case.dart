import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/features/chat/domain/entities/chat.dart';
import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class GetChatByIdUseCase {
  final ChatRepository repository;

  const GetChatByIdUseCase(this.repository);

  Future<Either<Failure, Chat>> call(String chatId) async {
    return await repository.getChatById(chatId);
  }
}
