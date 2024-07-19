import 'package:flutter/material.dart';
import 'package:lush_app/models/user_model.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/colors.dart';
import 'package:lush_app/constants/images.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/message_model.dart';

import 'package:lush_app/services/chat_provider.dart';
import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/widgets/custom_icon_button.dart';
import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/direct_message_chat_widget.dart';
import 'package:lush_app/widgets/lush_tokens_widget.dart';
import 'package:lush_app/widgets/send_message_widget.dart';

class DirectScreen extends StatefulWidget {
  const DirectScreen({super.key});

  @override
  State<DirectScreen> createState() => _DirectScreenState();
}

class _DirectScreenState extends State<DirectScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _chatScrollController = ScrollController();

  MessageModel? repliedMessage;

  void _updateReplyMessage(MessageModel message) {
    print('Updating reply message: ${message.id}');
    setState(() {
      repliedMessage = message;
    });
  }

  Future<String> _getOtherUserName(ChatModel chat) async {
    final currentUserId = FirebaseHelper.userHelper.getCurrentUserUid!;
    final otherUserId = chat.userIds.firstWhere((id) => id != currentUserId);
    final otherUser =
        await FirebaseHelper.userHelper.getUserWithUid(otherUserId);
    return otherUser?.chatInfo.username ?? 'Utente sconosciuto';
  }

  Widget _buildAppBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 28.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Direct',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'PLayfair Display',
            ),
          ),
          LushTokensWidget(),
        ],
      ),
    );
  }

  Widget _buildContactBar(BuildContext context, ChatModel chat) {
    final currentUserId = FirebaseHelper.userHelper.getCurrentUserUid;
    final List<UserModel> participants =
        Provider.of<ChatProvider>(context, listen: false).participants;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: cSecondaryColor,
                    ),
                    Text(
                      '28',
                      style: TextStyle(
                        color: cSecondaryColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: cLushTokenIcon,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        participants
                                .firstWhere((user) => user.id != currentUserId)
                                .chatInfo
                                .username ??
                            'Anonimo',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chat.lastMessage != null
                          ? Text(
                              '${participants.firstWhere((user) => user.id != currentUserId).chatInfo.lastSeen.hour.toString().padLeft(2, '0')}:${participants.firstWhere((user) => user.id != currentUserId).chatInfo.lastSeen.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                color: cSecondaryColor,
                icon: const Icon(
                  Icons.phone_outlined,
                  size: 30.0,
                ),
              ),
              IconButton(
                onPressed: () {},
                color: cSecondaryColor,
                icon: const Icon(
                  Icons.video_call_outlined,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ChatModel chat =
        Provider.of<ChatProvider>(context, listen: false).chat!;
    return CustomBackground(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            _buildAppBar(),
            _buildContactBar(context, chat),
            DirectMessageChatWidget(
              scrollController: _chatScrollController,
              onReply: _updateReplyMessage,
            ),
            repliedMessage != null
                ? Container(
                    color: Colors.red,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              repliedMessage!.senderId,
                            ),
                            Text(
                              repliedMessage!.text,
                            ),
                          ],
                        ),
                        CustomIconButton.small(
                          icon: Icons.cancel_outlined,
                          onPressed: () {
                            setState(() {
                              repliedMessage = null;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : Container(),
            SendMessageWidget(
              controller: _messageController,
              onMessageSent: (message) async {
                await FirebaseHelper.chatsHelper.sendMessage(
                  chat.id,
                  MessageModel(
                    id: '',
                    chatId: chat.id,
                    senderId: FirebaseHelper.userHelper.getCurrentUserUid!,
                    text: message,
                    timestamp: DateTime.now(),
                    replyToMessageId: repliedMessage?.id,
                  ),
                );
                setState(() {
                  repliedMessage = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
