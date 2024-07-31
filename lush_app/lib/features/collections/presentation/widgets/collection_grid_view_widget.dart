import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/core/commons/widgets/custom_loader.dart';
import 'package:lush_app/core/utils/show_snackbar.dart';
import 'package:lush_app/features/collections/domain/entities/collection_card.dart';
import 'package:lush_app/features/collections/presentation/bloc/collection_bloc.dart';
import 'package:lush_app/features/collections/presentation/bloc/collection_states.dart';
import 'package:lush_app/features/collections/presentation/widgets/collection_grid_view_item_widget.dart';
import 'package:lush_app/features/collections/presentation/widgets/overlay_card_widget.dart';

class CollectionGridViewWidget extends StatelessWidget {
  final int gridCrossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const CollectionGridViewWidget({
    super.key,
    this.gridCrossAxisCount = 3,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 16.0,
    this.childAspectRatio = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollectionBloc, CollectionState>(
      listener: (context, state) {
        if (state is CollectionErrorState) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is CollectionLoadingState) {
          return const CustomLoader();
        } else if (state is CollectionLoadedState) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCrossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: state.cards.length,
            itemBuilder: (context, index) => CollectionGridViewItemWidget(
              card: state.cards[index],
              onTap: () => _showOverlay(context, state.cards[index]),
            ),
          );
        }
        return const Center(child: Text('ERROR'));
      },
    );
  }

  void _showOverlay(BuildContext context, CollectionCard card) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.black.withOpacity(0.5),
              insetPadding: EdgeInsets.zero,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Center(
                    child: OverlayCardWidget(card: card),
                  ),
                ],
              ),
            ));
  }
}
