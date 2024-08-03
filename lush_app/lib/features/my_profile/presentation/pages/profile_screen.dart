import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_bloc.dart';
import 'package:lush_app/core/commons/user/presentation/bloc/user_states.dart';
import 'package:lush_app/core/commons/widgets/custom_app_bar_widget.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/core/commons/widgets/row_variable_counters_widget.dart';
import 'package:lush_app/core/commons/widgets/variable_counter_widget.dart';
import 'package:lush_app/features/my_profile/presentation/widgets/post_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Column(
        children: [
          const CustomAppBarWidget(title: 'Il Mio Profilo'),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(radius: 40.0),
                        const SizedBox(width: 16.0),
                        _buildCountersWidget(),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'My_name',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                            CustomText(
                              text: 'Una piccola creator su Lush',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,
              children: const [
                PostWidget(),
                PostWidget(),
                PostWidget(),
                PostWidget(),
                PostWidget(),
                PostWidget(),
                PostWidget(),
                PostWidget(),
                PostWidget(),
                PostWidget(),
                PostWidget(),
                PostWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountersWidget() {
    return const RowVariableCountersWidget(
      variableCounters: [
        VariableCounterWidget(
          maxWidth: 90.0,
          variableText: '47',
          label: 'Post',
        ),
        VariableCounterWidget(
          maxWidth: 90.0,
          variableText: '125.736',
          label: 'Follower',
        ),
        VariableCounterWidget(
          maxWidth: 90.0,
          variableText: '1.736',
          label: 'Seguiti',
        ),
      ],
    );
  }
}
