import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_background.dart';
import 'package:lush_app/core/commons/widgets/custom_app_bar_widget.dart';
import 'package:lush_app/core/commons/widgets/row_variable_counters_widget.dart';
import 'package:lush_app/core/commons/widgets/variable_counter_widget.dart';
import 'package:lush_app/features/collections/presentation/bloc/collection_bloc.dart';
import 'package:lush_app/features/collections/presentation/bloc/collection_events.dart';
import 'package:lush_app/features/collections/presentation/widgets/collection_grid_view_widget.dart';

class CollectionScreen extends StatelessWidget {
  final int gridCrossAxisCount = 3;

  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CollectionBloc>().add(GetCollectionEvent());
    return const CustomBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomAppBarWidget(
            title: 'Collection',
            showTokensCount: true,
          ),
          RowVariableCountersWidget(variableCounters: [
            VariableCounterWidget(variableText: '320', label: 'Foto'),
            VariableCounterWidget(variableText: '153', label: 'Video'),
            VariableCounterWidget(variableText: '473', label: 'Preferiti'),
          ]),
          Expanded(child: CollectionGridViewWidget()),
        ],
      ),
    );
  }
}
