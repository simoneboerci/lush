import 'package:equatable/equatable.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';

// Classe base per gli eventi messaggio
abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object?> get props => [];
}

// Evento chiamato quando l'utente corrente invia un messaggio ad un altro utente
class SendMessageEvent extends MessageEvent {
  final String chatId;
  final Message message;

  const SendMessageEvent({
    required this.chatId,
    required this.message,
  });

  @override
  List<Object?> get props => [chatId, message];
}

// Evento chiamato quando il messaggio inviato dall'utente corrente arriva all'altro utente
// (Se l'altro utente non ha connessione per ricevere nuovi messaggi questo evento non sarà chiamato)
class DeliverMessageEvent extends MessageEvent {
  final String chatId;
  final String messageId;
  final String userId;

  const DeliverMessageEvent({
    required this.chatId,
    required this.messageId,
    required this.userId,
  });

  @override
  List<Object?> get props => [chatId, messageId, userId];
}

// Evento chiamato quando l'utente corrente legge (entra in una chat con) dei messaggi non letti
class ReadMessageEvent extends MessageEvent {
  final String chatId;
  final String messageId;
  final String userId;

  const ReadMessageEvent({
    required this.chatId,
    required this.messageId,
    required this.userId,
  });

  @override
  List<Object?> get props => [chatId, messageId, userId];
}

// Evento chiamato quando viene nascosto un messaggio
class HideMessageEvent extends MessageEvent {
  final String chatId;
  final String messageId;
  final List<String> userIds;

  const HideMessageEvent({
    required this.chatId,
    required this.messageId,
    required this.userIds,
  });

  @override
  List<Object?> get props => [chatId, messageId, userIds];
}

// Evento chiamato quando viene mostrato un messaggio che prima era nascosto
class ShowMessageEvent extends MessageEvent {
  final String chatId;
  final String messageId;
  final List<String> userIds;

  const ShowMessageEvent({
    required this.chatId,
    required this.messageId,
    required this.userIds,
  });

  @override
  List<Object?> get props => [chatId, messageId, userIds];
}

// Evento chiamato quando viene cancellato un messaggio
class DeleteMessageEvent extends MessageEvent {
  final String chatId;
  final String messageId;

  const DeleteMessageEvent({
    required this.chatId,
    required this.messageId,
  });

  @override
  List<Object?> get props => [chatId, messageId];
}

// Evento chiamato quando l'utente modifica un messaggio
class EditMessageEvent extends MessageEvent {
  final String chatId;
  final String oldMessageId;
  final Message newMessage;

  const EditMessageEvent({
    required this.chatId,
    required this.oldMessageId,
    required this.newMessage,
  });

  @override
  List<Object?> get props => [chatId, oldMessageId, newMessage];
}

// Evento chiamato quando l'utente reagisce ad un messaggio
class ReactToMessageEvent extends MessageEvent {
  final String chatId;
  final String messageId;

  const ReactToMessageEvent({
    required this.chatId,
    required this.messageId,
  });

  @override
  List<Object?> get props => [chatId, messageId];
}

// Evento chiamato quando l'utente corrente cerca di ottenere un messaggio già inviato
class GetMessageEvent extends MessageEvent {
  final String chatId;
  final String messageId;

  const GetMessageEvent({
    required this.chatId,
    required this.messageId,
  });

  @override
  List<Object?> get props => [chatId, messageId];
}

// Evento chiamato quando l'utente aggiunge un messaggio ai preferiti
class AddMessageToFavoriteEvent extends MessageEvent {
  final String chatId;
  final String messageId;

  const AddMessageToFavoriteEvent({
    required this.chatId,
    required this.messageId,
  });

  @override
  List<Object?> get props => [chatId, messageId];
}

// Evento chiamato quando l'utente rimuove un messaggio dai preferiti
class RemoveMessageFromFavoriteEvent extends MessageEvent {
  final String chatId;
  final String messageId;

  const RemoveMessageFromFavoriteEvent({
    required this.chatId,
    required this.messageId,
  });

  @override
  List<Object?> get props => [chatId, messageId];
}
