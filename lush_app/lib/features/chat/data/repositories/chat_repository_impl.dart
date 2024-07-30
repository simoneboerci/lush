import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/exceptions/chat_remote_exceptions.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:lush_app/features/chat/data/models/chat_model.dart';
import 'package:lush_app/features/chat/domain/entities/chat.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';
import 'package:lush_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:lush_app/features/chat/domain/repositories/message_repository.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';
import 'package:lush_app/core/commons/user/domain/repositories/user_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  final UserRepository userRepository;
  final MessageRepository messageRepository;

  const ChatRepositoryImpl({
    required this.chatRemoteDataSource,
    required this.userRepository,
    required this.messageRepository,
  });

  @override
  Chat toEntity(ChatModel model) {
    return Chat(
      id: model.id,
      ownerId: model.ownerId,
      participantIds: model.participantIds,
      messages: model.messages
          .map((messageModel) => messageRepository.toEntity(messageModel))
          .toList(),
      pinnedMessageIds: model.pinnedMessageIds,
      favoriteBy: model.favoriteBy,
    );
  }

  @override
  ChatModel toModel(Chat entity) {
    return ChatModel(
      id: entity.id,
      ownerId: entity.ownerId,
      participantIds: entity.participantIds,
      messages: entity.messages
          .map((messageEntity) => messageRepository.toModel(messageEntity))
          .toList(),
      pinnedMessageIds: entity.pinnedMessageIds,
      favoriteBy: entity.favoriteBy,
    );
  }

  @override
  Future<Either<Failure, Chat>> getChatById(String chatId) async {
    try {
      // Ottieni il modello della chat corrispondente all'id
      final chatModel = await chatRemoteDataSource.getChatById(chatId);

      // Assicurati che la chat esista
      if (chatModel == null) {
        throw ChatNotFoundException(chatId: chatId);
      }

      // Ritorna la chat
      return right(toEntity(chatModel));
    } on ChatRemoteException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getChatParticipants(String chatId) async {
    try {
      // Recupera il chatModel direttamente dalla data source
      final ChatModel? chatModel =
          await chatRemoteDataSource.getChatById(chatId);

      // Assicurati che la chat esista
      if (chatModel == null) {
        return left(Failure(message: 'Chat $chatId not found'));
      }

      // Ottieni la lista dei partecipanti alla chat sotto forma di id
      final List<String> participantIds = chatModel.participantIds;

      // Crea una lista di partecipanti alla chat
      List<User> participants = [];

      // Recupera i dati di ogni partecipante dalla lista
      for (final participantId in participantIds) {
        final result = await userRepository.getUserById(participantId);
        if (result.isLeft()) {
          return result as Either<Failure, List<User>>;
        }

        // Aggiungi il partecipante alla lista
        participants.add(result.getOrElse((_) => throw ChatRemoteException(
            message: 'Unexpected error while handling Either type')));
      }

      // Ritorna la lista di partecipanti
      return right(participants);
    } on ChatRemoteException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getChatMessages(String chatId) async {
    try {
      // Ottieni la lista dei modelli di messaggi della chat corrispondente
      final messageModels = await chatRemoteDataSource.getChatMessages(chatId);
      // Converti la lista di modelli in entità
      final messages = messageModels
          .map((messageModel) => messageRepository.toEntity(messageModel))
          .toList();
      // Ritorna la lista di entità
      return right(messages);
    } on ChatRemoteException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Chat>> createChat(
      String user1Id, List<String> otherUserIds) async {
    try {
      // Ottieni il modello della chat creata
      final chatModel =
          await chatRemoteDataSource.createChat(user1Id, otherUserIds);

      // Converti la chat in entità
      final chat = toEntity(chatModel);

      // Ritorna l'entità
      return right(chat);
    } on ChatRemoteException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<void> kickOutUsersFromChat(String chatId, List<String> userIds) async {
    await chatRemoteDataSource.kickOutUsersFromChat(chatId, userIds);
  }

  @override
  Future<void> archiveChatForUsers(String chatId, List<String> userIds) async {
    await chatRemoteDataSource.archiveChatForUsers(chatId, userIds);
  }

  @override
  Future<void> deArchiveChatForUsers(
      String chatId, List<String> userIds) async {
    await chatRemoteDataSource.deArchiveChatForUsers(chatId, userIds);
  }

  @override
  Future<void> cleanChat(String chatId) async {
    await chatRemoteDataSource.cleanChat(chatId);
  }

  @override
  Future<void> deleteChat(String chatId) async {
    await chatRemoteDataSource.deleteChat(chatId);
  }

  @override
  Future<void> trasferChatOwnership(String chatId, String userId) async {
    await chatRemoteDataSource.trasferChatOwnership(chatId, userId);
  }

  @override
  Future<void> addChatToFavorite(String chatId, List<String> userIds) async {
    await chatRemoteDataSource.addChatToFavorite(chatId, userIds);
  }

  @override
  Future<void> removeChatFromFavorite(
      String chatId, List<String> userIds) async {
    await chatRemoteDataSource.removeChatFromFavorite(chatId, userIds);
  }

  @override
  Future<void> pinChatForUsers(String chatId, List<String> userIds) async {
    await chatRemoteDataSource.pinChatForUsers(chatId, userIds);
  }

  @override
  Future<void> unpinChatForUsers(String chatId, List<String> userIds) async {
    await chatRemoteDataSource.unpinChatForUsers(chatId, userIds);
  }

  @override
  Future<void> sendMessage(String chatId, Message message) async {
    final messageModel = messageRepository.toModel(message);
    await chatRemoteDataSource.sendMessage(chatId, messageModel);
  }
}
