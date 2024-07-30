import 'package:lush_app/core/exceptions/remote_exception.dart';

class ChatRemoteException extends RemoteException {
  String? chatId;

  ChatRemoteException({
    this.chatId,
    String message = 'ChatRemoteException: An error occurred with the chat',
  }) : super(message);

  @override
  String toString() {
    String baseMessage = super.toString();
    if (chatId != null) baseMessage += ' ChatID: $chatId';
    return baseMessage;
  }
}

class ChatNotFoundException extends ChatRemoteException {
  ChatNotFoundException({
    super.chatId,
    super.message = 'ChatNotFoundException: Chat not found',
  });
}

class ChatCreationException extends ChatRemoteException {
  ChatCreationException({
    super.chatId,
    super.message =
        'ChatCreationException: An error occurred creating the chat',
  });
}

class ChatMessagesException extends ChatRemoteException {
  ChatMessagesException({
    super.chatId,
    super.message =
        'ChatMessagesException: An error occurred with chat\'s messages',
  });
}

class ChatKickOutException extends ChatRemoteException {
  final String? userId;
  ChatKickOutException({
    super.chatId,
    super.message =
        'ChatKickOutException: An error occurred while kicking out user',
    this.userId,
  });

  @override
  String toString() {
    String baseMessage = super.toString();
    if (userId != null) baseMessage += ' UserID: $userId';
    return baseMessage;
  }
}

class ChatOwnershipTransferException extends ChatRemoteException {
  final String? userId;
  ChatOwnershipTransferException({
    super.chatId,
    super.message =
        'ChatOwnershipTransferException: An error occurred while trasfering ownership to user',
    this.userId,
  });

  @override
  String toString() {
    String baseMessage = super.toString();
    if (userId != null) baseMessage += ' UserID: $userId';
    return baseMessage;
  }
}

class ChatSendMessageException extends ChatRemoteException {
  final String? messageId;

  ChatSendMessageException({
    super.chatId,
    super.message =
        'ChatSendMessageException: An error occurred while sending message in chat',
    this.messageId,
  });

  @override
  String toString() {
    String baseMessage = super.toString();
    if (messageId != null) baseMessage += ' MessageID: $messageId';
    return baseMessage;
  }
}

class ChatAddToFavoriteException extends ChatRemoteException {
  ChatAddToFavoriteException({
    super.chatId,
    super.message =
        'ChatAddToFavoriteException: An error occurred while adding chat to favorite',
  });
}

class ChatRemoveFromFavoriteException extends ChatRemoteException {
  ChatRemoveFromFavoriteException({
    super.chatId,
    super.message =
        'ChatRemoveFromFavoriteException: An error occurred while removing chat from favorite',
  });
}

class ChatAddToArchiveException extends ChatRemoteException {
  ChatAddToArchiveException({
    super.chatId,
    super.message =
        'ChatAddToArchiveException: An error occurred while adding chat to archive',
  });
}

class ChatRemoveFromArchiveException extends ChatRemoteException {
  ChatRemoveFromArchiveException({
    super.chatId,
    super.message =
        'ChatRemoveFromArchiveException: An error occurred while removing chat from archive',
  });
}

class ChatCleanException extends ChatRemoteException {
  ChatCleanException({
    super.chatId,
    super.message = 'ChatCleanException: An error occurred while cleaning chat',
  });
}

class ChatDeleteException extends ChatRemoteException {
  ChatDeleteException({
    super.chatId,
    super.message =
        'ChatDeleteException: An error occurred while deleting chat',
  });
}

class ChatPinException extends ChatRemoteException {
  ChatPinException({
    super.chatId,
    super.message = 'ChatPinException: An error occurred while pinning chat',
  });
}

class ChatUnpinException extends ChatRemoteException {
  ChatUnpinException({
    super.chatId,
    super.message =
        'ChatUnpinException: An error occurred while unpinning chat',
  });
}
