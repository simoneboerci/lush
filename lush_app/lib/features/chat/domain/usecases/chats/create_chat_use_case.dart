import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/features/chat/domain/entities/chat.dart';
import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';

class CreateChatUseCase {
  final ChatRepository repository;

  const CreateChatUseCase(this.repository);

  Future<Either<Failure, Chat>> call(
      String user1Id, List<String> otherUserIds) async {
    return await repository.createChat(user1Id, otherUserIds);
  }
}
