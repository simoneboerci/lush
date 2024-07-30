import 'package:flutter/material.dart';

class SendMessageWidgetViewModel extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();

  final Function(String)? onMessageChanged;
  final Function(String)? onMessageSent;

  bool get isMessageEmpty => textController.text.isEmpty;

  SendMessageWidgetViewModel({
    this.onMessageChanged,
    this.onMessageSent,
  }) {
    textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    onMessageChanged?.call(textController.text);
    notifyListeners();
  }

  void sendMessage() {
    final message = textController.text;
    if (message.isNotEmpty) {
      onMessageSent?.call(message);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    super.dispose();
  }
}
