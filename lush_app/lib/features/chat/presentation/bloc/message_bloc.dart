import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/add_message_to_favorite_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/contains_photo_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/contains_video_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/delete_message_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/delivered_to_use_cast.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/favorite_by_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/get_message_by_id_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/hide_message_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/read_by_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/remove_message_from_favorite_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/replied_to_message_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/send_message_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/sent_by_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/sent_to_use_case.dart';
import 'package:lush_app/features/chat/domain/usecases/messages/show_message_use_case.dart';
import 'package:lush_app/features/chat/presentation/bloc/message_event.dart';
import 'package:lush_app/features/chat/presentation/bloc/message_states.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessageByIdUseCase getMessageByIdUseCase;
//------------------------------------------------
  final SendMessageUseCase sendMessageUseCase;
//------------------------------------------------
  final DeliveredToUseCase deliveredToUseCase;
  final ReadByUseCase readByUseCase;
//------------------------------------------------
  final HideMessageUseCase hideMessageUseCase;
  final ShowMessageUseCase showMessageUseCase;
//------------------------------------------------
  final DeleteMessageUseCase deleteMessageUseCase;
//------------------------------------------------
  final AddMessageToFavoriteUseCase addMessageToFavoriteUseCase;
  final RemoveMessageFromFavoriteUseCase removeMessageFromFavoriteUseCase;
//------------------------------------------------

  final ContainsPhotoUseCase containsPhotoUseCase;
  final ContainsVideoUseCase containsVideoUseCase;
  final FavoriteByUseCase favoriteByUseCase;
  final RepliedToMessageUseCase repliedToMessageUseCase;
  final SentByUseCase sentByUseCase;
  final SentToUseCase sentToUseCase;

  MessageBloc({
    required this.getMessageByIdUseCase,
//------------------------------------------------
    required this.sendMessageUseCase,
//------------------------------------------------
    required this.deliveredToUseCase,
    required this.readByUseCase,
//------------------------------------------------
    required this.hideMessageUseCase,
    required this.showMessageUseCase,
//------------------------------------------------
    required this.deleteMessageUseCase,
//------------------------------------------------
    required this.addMessageToFavoriteUseCase,
    required this.removeMessageFromFavoriteUseCase,
//------------------------------------------------
    required this.containsPhotoUseCase,
    required this.containsVideoUseCase,
    required this.favoriteByUseCase,
    required this.repliedToMessageUseCase,
    required this.sentByUseCase,
    required this.sentToUseCase,
  }) : super(MessageInitialState()) {
    on<GetMessageEvent>(_onGetMessage);
//------------------------------------------------
    on<SendMessageEvent>(_onSendMessage);
//------------------------------------------------
    on<DeliverMessageEvent>(_onDeliverMessage);
    on<ReadMessageEvent>(_onReadMessage);
//------------------------------------------------
    on<HideMessageEvent>(_onHideMessage);
    on<ShowMessageEvent>(_onShowMessage);
//------------------------------------------------
    on<DeleteMessageEvent>(_onDeleteMessage);
//------------------------------------------------
    on<AddMessageToFavoriteEvent>(_addMessageToFavorite);
    on<RemoveMessageFromFavoriteEvent>(_removeMessageFromFavorite);
//------------------------------------------------
  }

//------------------------------------------------

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<MessageState> emit) async {
    emit(MessageSendingState(event.message));
    try {
      await sendMessageUseCase.call(event.chatId, event.message);
      emit(MessageSentState(event.message));
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

  //TODO: Future<void> _onSendMessageTo()

//------------------------------------------------

  Future<void> _onDeliverMessage(
      DeliverMessageEvent event, Emitter<MessageState> emit) async {
    try {
      final delivered = await deliveredToUseCase.call(
          event.chatId, event.messageId, event.userId);
      if (delivered) {
        final message =
            await getMessageByIdUseCase.call(event.chatId, event.messageId);
        if (message != null) {
          emit(MessageDeliveredState(message));
        } else {
          emit(MessageErrorState(
              'Message with id: ${event.messageId} not found in chat: ${event.chatId}'));
        }
      } else {
        //TODO: Call message not delivered state
      }
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

  Future<void> _onReadMessage(
      ReadMessageEvent event, Emitter<MessageState> emit) async {
    try {
      final read =
          await readByUseCase.call(event.chatId, event.messageId, event.userId);
      if (read) {
        final message =
            await getMessageByIdUseCase.call(event.chatId, event.messageId);
        if (message != null) {
          emit(MessageReadState(message));
        } else {
          emit(MessageErrorState(
              'Message with id: ${event.messageId}not found in chat: ${event.chatId}'));
        }
      } else {
        //TODO: Call message not readed state
      }
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

//------------------------------------------------

  Future<void> _onHideMessage(
      HideMessageEvent event, Emitter<MessageState> emit) async {
    try {
      await hideMessageUseCase.call(
          event.chatId, event.messageId, event.userIds);
      final message =
          await getMessageByIdUseCase.call(event.chatId, event.messageId);
      if (message != null) {
        emit(MessageHiddenState(message));
      } else {
        emit(MessageErrorState(
            'Message with id: ${event.messageId} not found in chat: ${event.chatId}'));
      }
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

  Future<void> _onShowMessage(
      ShowMessageEvent event, Emitter<MessageState> emit) async {
    try {
      await showMessageUseCase.call(
          event.chatId, event.messageId, event.userIds);

      final message =
          await getMessageByIdUseCase(event.chatId, event.messageId);
      if (message != null) {
        emit(MessageShowedState(message));
      } else {
        emit(MessageErrorState(
            'Message with id: ${event.messageId} not found in chat: ${event.chatId}'));
      }
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

//------------------------------------------------

  Future<void> _onDeleteMessage(
      DeleteMessageEvent event, Emitter<MessageState> emit) async {
    try {
      final message =
          await getMessageByIdUseCase(event.chatId, event.messageId);

      if (message != null) {
        await deleteMessageUseCase.call(event.chatId, event.messageId);
        emit(MessageDeletedState(message));
      } else {
        emit(MessageErrorState(
            'Message with id: ${event.messageId} not found in chat: ${event.chatId}'));
      }
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

//------------------------------------------------

  Future<void> _addMessageToFavorite(
      AddMessageToFavoriteEvent event, Emitter<MessageState> emit) async {
    try {
      await addMessageToFavoriteUseCase(event.chatId, event.messageId);
      final message =
          await getMessageByIdUseCase(event.chatId, event.messageId);
      if (message != null) {
        emit(MessageAddedToFavoriteState(message));
      } else {
        emit(MessageErrorState(
            'Message with id: ${event.messageId} not found in chat: ${event.chatId}'));
      }
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

  Future<void> _removeMessageFromFavorite(
      RemoveMessageFromFavoriteEvent event, Emitter<MessageState> emit) async {
    try {
      await removeMessageFromFavoriteUseCase(event.chatId, event.messageId);
      final message =
          await getMessageByIdUseCase(event.chatId, event.messageId);
      if (message != null) {
        emit(MessageRemovedFromFavoriteState(message));
      } else {
        emit(MessageErrorState(
            'Message with id: ${event.messageId} not found in chat: ${event.chatId}'));
      }
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

//------------------------------------------------

  Future<void> _onGetMessage(
      GetMessageEvent event, Emitter<MessageState> emit) async {
    //TODO: Call message loading state

    try {
      final message =
          await getMessageByIdUseCase.call(event.chatId, event.messageId);
      if (message != null) {
        emit(MessageSentState(message));
      } else {
        emit(MessageErrorState(
            'Message with id: ${event.messageId} not found in chat: ${event.chatId}'));
      }
    } catch (e) {
      emit(MessageErrorState(e.toString()));
    }
  }

//------------------------------------------------

  //TODO: Future<void> _onReplyToMessage()
}
