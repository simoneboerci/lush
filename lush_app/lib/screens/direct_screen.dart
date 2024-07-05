import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';
import 'package:lush_app/constants/images.dart';
import 'package:lush_app/models/direct_message.dart';
import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/widgets/custom_background.dart';
import 'package:lush_app/widgets/direct_message_chat_widget.dart';
import 'package:lush_app/widgets/lush_tokens_widget.dart';
import 'package:lush_app/widgets/send_message_widget.dart';

class DirectScreen extends StatelessWidget {
  DirectScreen({super.key});

  final TextEditingController _messageController = TextEditingController();

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

  Widget _buildContactBar() {
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
                onPressed: () {},
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
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: cLushTokenIcon,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    children: [
                      Text(
                        'Username_88',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Attivo/a 2h fa',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
    return CustomBackground(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            _buildAppBar(),
            _buildContactBar(),
            const DirectMessageChatWidget(),
            SendMessageWidget(
              controller: _messageController,
              onMessageSent: (message) async {
                await FirebaseHelper.sendMessage(
                  DirectMessage(
                    id: 'ejbfqwbfjqwbdqwd',
                    chatId: 'iwugfouqwhfouqwhdoqdq',
                    senderId: 'currentUserId',
                    text: message,
                    timestamp: DateTime.now(),
                    isDelivered: true,
                    isRead: true,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
