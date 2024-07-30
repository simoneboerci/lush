import 'package:equatable/equatable.dart';
import 'package:lush_app/features/chat/domain/entities/chat.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';
import 'package:lush_app/core/commons/user/domain/entities/user.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatCreatingState extends ChatState {}

class ChatCreatedState extends ChatState {
  final Chat chat;

  const ChatCreatedState(this.chat);

  @override
  List<Object?> get props => [chat];
}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final Chat chat;

  const ChatLoadedState(this.chat);

  @override
  List<Object?> get props => [chat];
}

class ChatParticipantsLoadingState extends ChatState {}

class ChatParticipantsLoadedState extends ChatState {
  final List<User> participants;

  const ChatParticipantsLoadedState(this.participants);

  @override
  List<Object?> get props => [participants];
}

class ChatMessagesLoadingState extends ChatState {}

class ChatMessagesLoadedState extends ChatState {
  final List<Message> messages;

  const ChatMessagesLoadedState(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatMessageSendingState extends ChatState {
  final Message message;

  const ChatMessageSendingState(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatMessageSentState extends ChatState {
  final Message message;

  const ChatMessageSentState(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatCleaningState extends ChatState {}

class ChatCleanedState extends ChatState {}

class ChatDeletingState extends ChatState {}

class ChatDeletedState extends ChatState {}

class ChatArchivingState extends ChatState {}

class ChatArchivedState extends ChatState {}

class ChatDeArchivingState extends ChatState {}

class ChatDeArchivedState extends ChatState {}

class ChatTransferingOwnershipState extends ChatState {}

class ChatTransferedOwnershipState extends ChatState {}

class ChatKickingOutUsersState extends ChatState {}

class ChatKickedOutUsersState extends ChatState {}

class ChatAddingToFavoriteState extends ChatState {}

class ChatAddedToFavoriteState extends ChatState {}

class ChatRemovingFromFavoriteState extends ChatState {}

class ChatRemovedFromFavoriteState extends ChatState {}

class ChatPinningState extends ChatState {}

class ChatPinnedState extends ChatState {}

class ChatUnpinningState extends ChatState {}

class ChatUnpinnedState extends ChatState {}

class ChatErrorState extends ChatState {
  final String error;

  const ChatErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
