import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lush_app/core/constants/images.dart';

import 'package:lush_app/features/chat/presentation/viewmodels/contact_list_tile_view_model.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_states.dart';

import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/features/chat/presentation/widgets/message_status_widget.dart';

class ContactListTileWidget extends StatelessWidget {
  final ContactListTileViewModel viewModel;

  const ContactListTileWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          return const CircularProgressIndicator();
        } else if (state is UserErrorState) {
          return Center(child: Text(state.message));
        }

        return _buildWidget();
      },
    );
  }

  Widget _buildWidget() {
    return Padding(
        padding: viewModel.margin,
        child: ListTile(
          onTap: viewModel.onTap,
          leading: CircleAvatar(
            radius: viewModel.imageRadius,
            backgroundImage: cLushTokenIcon,
          ),
          title: _buildTitle(),
          subtitle: viewModel.lastMessage != null ? _buildSubtitle() : null,
          trailing: viewModel.lastMessage != null ? _buildTrailing() : null,
        ));
  }

  Widget _buildTitle() {
    return CustomText(
      text: viewModel.contactName,
      color: viewModel.titleTextColor,
      fontWeight: viewModel.titleFontWeight,
      maxLines: viewModel.titleMaxLines,
      textOverflow: viewModel.titleTextOverflow,
    );
  }

  Widget _buildSubtitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (viewModel.isLastMessageFromCurrentUser &&
            viewModel.messageStatusViewModel != null)
          MessageStatusWidget(viewModel: viewModel.messageStatusViewModel!),
        const SizedBox(width: 4.0),
        Expanded(
            child: CustomText(
          text: viewModel.lastMessageText,
          color: viewModel.subtitleTextColor,
          fontSize: viewModel.subtitleFontSize,
          maxLines: viewModel.subtitleMaxLines,
          textOverflow: viewModel.subtitleTextOverflow,
        )),
      ],
    );
  }

  Widget _buildTrailing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          text: viewModel.lastMessageTime,
          color: viewModel.trailingTextColor,
          fontSize: viewModel.trailingFontSize,
        ),
      ],
    );
  }
}
