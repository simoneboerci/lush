import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/repository.dart';
import 'package:lush_app/features/chat/data/models/chat_model.dart';
import 'package:lush_app/features/chat/domain/entities/chat.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';

abstract class ChatRepository implements Repository<Chat, ChatModel> {
  // Ottieni la chat tramite l'id
  Future<Either<Failure, Chat>> getChatById(String chatId);

  // Ottieni la lista di utenti che partecipa ad una chat
  Future<Either<Failure, List<User>>> getChatParticipants(String chatId);

  // Ottieni la lista di messaggi presenti nella chat
  Future<Either<Failure, List<Message>>> getChatMessages(String chatId);

  // Crea una nuova chat (chat di gruppo se contiene più di due utenti)
  Future<Either<Failure, Chat>> createChat(
      String user1Id, List<String> otherUserIds);

  // Fai uscire uno o più utenti dalla chat
  Future<void> kickOutUsersFromChat(String chatId, List<String> userIds);

  // Archivia la chat ad uno o più utenti
  Future<void> archiveChatForUsers(String chatId, List<String> userIds);
  // Togli la chat dall'archivio per uno o più utenti
  Future<void> deArchiveChatForUsers(String chatId, List<String> userIds);

  // Cancella tutti i messaggi all'interno della chat
  Future<void> cleanChat(String chatId);
  // Elimina la chat cancellando anche tutti i messaggi all'interno
  Future<void> deleteChat(String chatId);

  // Trasferisci la proprietà di una chat ad un utente
  Future<void> trasferChatOwnership(String chatId, String userId);

  // Aggiungi la chat alla lista di chat preferite per uno o più utenti
  Future<void> addChatToFavorite(String chatId, List<String> userIds);
  // Rimuovi la chat dalla lista delle chat preferite per uno o più utenti
  Future<void> removeChatFromFavorite(String chatId, List<String> userIds);

  // Fissa in alto una chat per uno o più utenti
  Future<void> pinChatForUsers(String chatId, List<String> userIds);
  // Togli il pin a una chat per uno o più utenti
  Future<void> unpinChatForUsers(String chatId, List<String> userIds);

  // Invia un messaggio nella chat
  Future<void> sendMessage(String chatId, Message message);
}
