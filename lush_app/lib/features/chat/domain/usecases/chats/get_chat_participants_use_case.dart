import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';

class GetChatParticipantsUseCase {
  final ChatRepository repository;

  const GetChatParticipantsUseCase(this.repository);

  Future<Either<Failure, List<User>>> call(String chatId) async {
    return await repository.getChatParticipants(chatId);
  }
}
