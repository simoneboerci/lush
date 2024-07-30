import 'package:equatable/equatable.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';

// Classe di base per gli stati dei messaggi
abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

// Stato di partenza per ogni messaggio
class MessageInitialState extends MessageState {}

// Invio del messaggio in corso
class MessageSendingState extends MessageState {
  final Message message;

  const MessageSendingState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio è stato inviato con successo
class MessageSentState extends MessageState {
  final Message message;

  const MessageSentState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio è stato ricevuto dall'altro utente
class MessageDeliveredState extends MessageState {
  final Message message;

  const MessageDeliveredState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio è stato letto dall'altro utente
class MessageReadState extends MessageState {
  final Message message;

  const MessageReadState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio è stato nascosto
class MessageHiddenState extends MessageState {
  final Message message;

  const MessageHiddenState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio è stato mostrato dopo essere stato nascosto
class MessageShowedState extends MessageState {
  final Message message;

  const MessageShowedState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio è stato cancellato
class MessageDeletedState extends MessageState {
  final Message message;

  const MessageDeletedState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio è stato aggiunto ai preferiti
class MessageAddedToFavoriteState extends MessageState {
  final Message message;

  const MessageAddedToFavoriteState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio è stato rimosso dai preferiti
class MessageRemovedFromFavoriteState extends MessageState {
  final Message message;

  const MessageRemovedFromFavoriteState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio è stato modificato
class MessageEditedState extends MessageState {
  final Message message;

  const MessageEditedState(this.message);

  @override
  List<Object?> get props => [message];
}

// Il messaggio ha ottenuto una reazione
class MessageReactedState extends MessageState {
  final Message message;

  const MessageReactedState(this.message);

  @override
  List<Object?> get props => [message];
}

// Stato di errore del messaggio
class MessageErrorState extends MessageState {
  final String error;

  const MessageErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
