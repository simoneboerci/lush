import 'package:lush_app/core/exceptions/remote_exception.dart';

class MessageRemoteException extends RemoteException {
  final String? chatId;
  final String? messageId;

  MessageRemoteException(
      {String message =
          'MessageRemoteException: An error occurred with the message',
      this.chatId,
      this.messageId})
      : super(message);

  @override
  String toString() {
    String baseMessage = super.toString();
    if (chatId != null) baseMessage += ' Chat ID: $chatId';
    if (messageId != null) baseMessage += ' Message ID: $messageId';
    return baseMessage;
  }
}

class MessageNotFoundException extends MessageRemoteException {
  MessageNotFoundException({
    super.chatId,
    super.messageId,
    super.message = 'MessageNotFoundException: Message not found',
  });
}

class MessageSendFailedException extends MessageRemoteException {
  MessageSendFailedException({
    super.chatId,
    super.messageId,
    super.message = 'MessageSendFailedException: Failed to send message',
  });
}

class MessageDeleteFailedException extends MessageRemoteException {
  MessageDeleteFailedException({
    super.chatId,
    super.messageId,
    super.message = 'MessageDeleteFailedException: Failed to delete message',
  });
}

class MessageAddToFavoriteException extends MessageRemoteException {
  MessageAddToFavoriteException({
    super.chatId,
    super.messageId,
    super.message =
        'MessageAddToFavoriteException: Failed to add message to favorite',
  });
}

class MessageRemoveToFavoriteException extends MessageRemoteException {
  MessageRemoveToFavoriteException({
    super.chatId,
    super.messageId,
    super.message =
        'MessageRemoveToFavoriteException: Failed to remove message from favorite',
  });
}
