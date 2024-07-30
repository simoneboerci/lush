import 'package:equatable/equatable.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class CreateChatEvent extends ChatEvent {
  final String user1Id;
  final List<String> otherUserIds;

  const CreateChatEvent(this.user1Id, this.otherUserIds);

  @override
  List<Object?> get props => [user1Id, otherUserIds];
}

class LoadChatEvent extends ChatEvent {
  final String chatId;

  const LoadChatEvent(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class LoadChatParticipantsEvent extends ChatEvent {
  final String chatId;

  const LoadChatParticipantsEvent(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class LoadChatMessagesEvent extends ChatEvent {
  final String chatId;

  const LoadChatMessagesEvent(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final Message message;

  const SendMessageEvent(this.chatId, this.message);

  @override
  List<Object?> get props => [chatId, message];
}

class CleanChatEvent extends ChatEvent {
  final String chatId;

  const CleanChatEvent(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class DeleteChatEvent extends ChatEvent {
  final String chatId;

  const DeleteChatEvent(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class ArchiveChatForUsersEvent extends ChatEvent {
  final String chatId;
  final List<String> userIds;

  const ArchiveChatForUsersEvent(this.chatId, this.userIds);

  @override
  List<Object?> get props => [chatId, userIds];
}

class DeArchiveChatForUsersEvent extends ChatEvent {
  final String chatId;
  final List<String> userIds;

  const DeArchiveChatForUsersEvent(this.chatId, this.userIds);

  @override
  List<Object?> get props => [chatId, userIds];
}

class KickOutUsersFromChatEvent extends ChatEvent {
  final String chatId;
  final List<String> userIds;

  const KickOutUsersFromChatEvent(this.chatId, this.userIds);

  @override
  List<Object?> get props => [chatId, userIds];
}

class TransferChatOwnershipEvent extends ChatEvent {
  final String chatId;
  final String userId;

  const TransferChatOwnershipEvent(this.chatId, this.userId);

  @override
  List<Object?> get props => [chatId, userId];
}

class AddChatToFavoritesEvent extends ChatEvent {
  final String chatId;
  final List<String> userIds;

  const AddChatToFavoritesEvent(this.chatId, this.userIds);

  @override
  List<Object?> get props => [chatId, userIds];
}

class RemoveChatFromFavoritesEvent extends ChatEvent {
  final String chatId;
  final List<String> userIds;

  const RemoveChatFromFavoritesEvent(this.chatId, this.userIds);

  @override
  List<Object?> get props => [chatId, userIds];
}

class PinChatEvent extends ChatEvent {
  final String chatId;
  final List<String> userIds;

  const PinChatEvent(this.chatId, this.userIds);

  @override
  List<Object?> get props => [chatId, userIds];
}

class UnpinChatEvent extends ChatEvent {
  final String chatId;
  final List<String> userIds;

  const UnpinChatEvent(this.chatId, this.userIds);

  @override
  List<Object?> get props => [chatId, userIds];
}
