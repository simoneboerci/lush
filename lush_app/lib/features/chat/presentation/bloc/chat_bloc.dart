import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/add_chat_to_favorite_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/archive_chat_for_users_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/clean_chat_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/create_chat_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/de_archive_chat_for_users_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/delete_chat_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/get_chat_by_id_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/get_chat_messages_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/get_chat_participants_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/kick_out_users_from_chat_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/pin_chat_for_users_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/remove_chat_from_favorite_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/send_message_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/transfer_chat_ownership_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/chats/unpin_chat_for_users_use_case.dart';
import 'package:lush_app/features/chat/presentation/bloc/chat_events.dart';
import 'package:lush_app/features/chat/presentation/bloc/chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
//------------------------------------------------
  final GetChatByIdUseCase getChatByIdUseCase;
  final GetChatParticipantsUseCase getChatParticipantsUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;
//------------------------------------------------
  final CreateChatUseCase createChatUseCase;
//------------------------------------------------
  final KickOutUsersFromChatUseCase kickOutUsersFromChatUseCase;
//------------------------------------------------
  final ArchiveChatForUsersUseCase archiveChatForUsersUseCase;
  final DeArchiveChatForUsersUseCase deArchiveChatForUsersUseCase;
//------------------------------------------------
  final CleanChatUseCase cleanChatUseCase;
  final DeleteChatUseCase deleteChatUseCase;
//------------------------------------------------
  final TransferChatOwnershipUseCase transferChatOwnershipUseCase;
//------------------------------------------------
  final AddChatToFavoriteUseCase addChatToFavoriteUseCase;
  final RemoveChatFromFavoriteUseCase removeChatFromFavoriteUseCase;
//------------------------------------------------
  final PinChatForUsersUseCase pinChatForUsersUseCase;
  final UnpinChatForUsersUseCase unpinChatForUsersUseCase;
//------------------------------------------------
  final SendMessageUseCase sendMessageUseCase;
//------------------------------------------------

  ChatBloc({
    //------------------------------------------------
    required this.getChatByIdUseCase,
    required this.getChatParticipantsUseCase,
    required this.getChatMessagesUseCase,
    //------------------------------------------------
    required this.createChatUseCase,
    //------------------------------------------------
    required this.kickOutUsersFromChatUseCase,
    //------------------------------------------------
    required this.archiveChatForUsersUseCase,
    required this.deArchiveChatForUsersUseCase,
    //------------------------------------------------
    required this.cleanChatUseCase,
    required this.deleteChatUseCase,
    //------------------------------------------------
    required this.transferChatOwnershipUseCase,
    //------------------------------------------------
    required this.addChatToFavoriteUseCase,
    required this.removeChatFromFavoriteUseCase,
    //------------------------------------------------
    required this.pinChatForUsersUseCase,
    required this.unpinChatForUsersUseCase,
    //------------------------------------------------
    required this.sendMessageUseCase,
    //------------------------------------------------
  }) : super(ChatInitialState()) {
    //------------------------------------------------
    on<LoadChatEvent>(_onGetChatById);
    on<LoadChatParticipantsEvent>(_onGetChatParticipants);
    on<LoadChatMessagesEvent>(_onGetChatMessages);
    //------------------------------------------------
    on<CreateChatEvent>(_onCreateChat);
    //------------------------------------------------
    on<KickOutUsersFromChatEvent>(_onKickOutUserFromChat);
    //------------------------------------------------
    on<ArchiveChatForUsersEvent>(_onArchiveChatForUsers);
    on<DeArchiveChatForUsersEvent>(_onDeArchiveChatForUsers);
    //------------------------------------------------
    on<CleanChatEvent>(_onCleanChat);
    on<DeleteChatEvent>(_onDeleteChat);
    //------------------------------------------------
    on<TransferChatOwnershipEvent>(_ontransferChatOwnership);
    //------------------------------------------------
    on<AddChatToFavoritesEvent>(_onAddChatToFavorite);
    on<RemoveChatFromFavoritesEvent>(_onRemoveChatFromFavorite);
    //------------------------------------------------
    on<PinChatEvent>(_onPinChatForUsers);
    on<UnpinChatEvent>(_onUnpinChatForUsers);
    //------------------------------------------------
    on<SendMessageEvent>(_onSendMessage);
  }

  //------------------------------------------------

  Future<void> _onGetChatById(
      LoadChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    final response = await getChatByIdUseCase.call(event.chatId);
    response.fold((failure) => ChatErrorState(failure.message),
        (chat) => ChatLoadedState(chat));
  }

  Future<void> _onGetChatParticipants(
      LoadChatParticipantsEvent event, Emitter<ChatState> emit) async {
    emit(ChatParticipantsLoadingState());
    final response = await getChatParticipantsUseCase.call(event.chatId);
    response.fold((failure) => ChatErrorState(failure.message),
        (participants) => ChatParticipantsLoadedState(participants));
  }

  Future<void> _onGetChatMessages(
      LoadChatMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatMessagesLoadingState());
    final response = await getChatMessagesUseCase.call(event.chatId);
    response.fold((failure) => ChatErrorState(failure.message),
        (messages) => ChatMessagesLoadedState(messages));
  }

  //------------------------------------------------

  Future<void> _onCreateChat(
      CreateChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatCreatingState());
    final response =
        await createChatUseCase.call(event.user1Id, event.otherUserIds);
    response.fold((failure) => ChatErrorState(failure.message),
        (chat) => ChatCreatedState(chat));
  }

  //------------------------------------------------

  Future<void> _onKickOutUserFromChat(
      KickOutUsersFromChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatKickingOutUsersState());

    try {
      await kickOutUsersFromChatUseCase.call(event.chatId, event.userIds);
      emit(ChatKickedOutUsersState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  //------------------------------------------------

  Future<void> _onArchiveChatForUsers(
      ArchiveChatForUsersEvent event, Emitter<ChatState> emit) async {
    emit(ChatArchivingState());
    try {
      await archiveChatForUsersUseCase.call(event.chatId, event.userIds);
      emit(ChatArchivedState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  Future<void> _onDeArchiveChatForUsers(
      DeArchiveChatForUsersEvent event, Emitter<ChatState> emit) async {
    emit(ChatDeArchivingState());

    try {
      await deArchiveChatForUsersUseCase.call(event.chatId, event.userIds);
      emit(ChatDeArchivedState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  //------------------------------------------------

  Future<void> _onCleanChat(
      CleanChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatCleaningState());
    try {
      await cleanChatUseCase.call(event.chatId);
      emit(ChatCleanedState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteChat(
      DeleteChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatDeletingState());
    try {
      await deleteChatUseCase.call(event.chatId);
      emit(ChatDeletedState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  Future<void> _ontransferChatOwnership(
      TransferChatOwnershipEvent event, Emitter<ChatState> emit) async {
    emit(ChatTransferingOwnershipState());
    try {
      await transferChatOwnershipUseCase.call(event.chatId, event.userId);
      emit(ChatTransferedOwnershipState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  //------------------------------------------------

  Future<void> _onAddChatToFavorite(
      AddChatToFavoritesEvent event, Emitter<ChatState> emit) async {
    emit(ChatAddingToFavoriteState());
    try {
      await addChatToFavoriteUseCase.call(event.chatId, event.userIds);
      emit(ChatAddedToFavoriteState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  Future<void> _onRemoveChatFromFavorite(
      RemoveChatFromFavoritesEvent event, Emitter<ChatState> emit) async {
    emit(ChatRemovingFromFavoriteState());
    try {
      await removeChatFromFavoriteUseCase.call(event.chatId, event.userIds);
      emit(ChatRemovedFromFavoriteState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  //------------------------------------------------

  Future<void> _onPinChatForUsers(
      PinChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatPinningState());
    try {
      await pinChatForUsersUseCase.call(event.chatId, event.userIds);
      emit(ChatPinnedState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  Future<void> _onUnpinChatForUsers(
      UnpinChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatUnpinningState());
    try {
      await unpinChatForUsersUseCase.call(event.chatId, event.userIds);
      emit(ChatUnpinnedState());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  //------------------------------------------------

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatMessageSendingState(event.message));
    try {
      await sendMessageUseCase.call(event.chatId, event.message);
      emit(ChatMessageSentState(event.message));
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }
}
