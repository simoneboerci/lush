import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_icon_button.dart';
import 'package:lush_app/core/constants/colors.dart';
import 'package:lush_app/features/collections/presentation/viewmodels/overlay_card_widget_view_model.dart';
import 'package:lush_app/features/collections/presentation/widgets/collection_card_buttons_row.dart';
import 'package:lush_app/features/collections/presentation/widgets/collection_card_frame_widget.dart';
import 'package:lush_app/features/collections/presentation/widgets/collection_card_hashtags_widget.dart';
import 'package:lush_app/features/collections/presentation/widgets/collection_card_image_widget.dart';
import 'package:lush_app/features/collections/presentation/widgets/collection_card_text_widget.dart';

class OverlayCardWidget extends StatefulWidget {
  final OverlayCardWidgetViewModel viewModel;

  const OverlayCardWidget({
    super.key,
    required this.viewModel,
  });

  @override
  OverlayCardWidgetState createState() => OverlayCardWidgetState();
}

class OverlayCardWidgetState extends State<OverlayCardWidget> {
  void _onPanStart() {
    setState(() {
      widget.viewModel.isDragging = true;
    });
  }

  void _onPanEnd() {
    widget.viewModel.resetValues();
    setState(() {
      widget.viewModel.isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.viewModel.getOverlayWidth(screenSize.width),
      height: widget.viewModel.getOverlayHeight(screenSize.height),
      child: GestureDetector(
        onPanStart: (_) => _onPanStart(),
        onPanUpdate: (details) =>
            widget.viewModel.onPanUpdate(details, screenSize),
        onPanEnd: (_) => _onPanEnd(),
        child: ValueListenableBuilder<Offset>(
          valueListenable: widget.viewModel.tiltNotifier,
          builder: (context, tilt, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(tilt.dy * 0.2)
                ..rotateY(-tilt.dx * 0.2),
              alignment: FractionalOffset.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      widget.viewModel.backgroundBorderRadius),
                  color: widget.viewModel.backgroundColor,
                ),
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                widget.viewModel.backgroundBorderRadius),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                _buildParallaxImage(),
                                _buildColoredFrame(),
                                _buildDustOverlays(),
                                _buildParallaxTexts(),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildHashtags(),
                            _buildButtons(),
                            const SizedBox(height: 4.0),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildColoredFrame() {
    return ValueListenableBuilder<Offset>(
      valueListenable: widget.viewModel.offsetNotifier,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset * 0.2,
          child: CollectionCardFrameWidget(
            borderRadius: widget.viewModel.backgroundBorderRadius,
          ),
        );
      },
    );
  }

  Widget _buildDustOverlays() {
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.offsetNotifier,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset * 0.25,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: widget.viewModel.isDragging ? 1.0 : 0.0,
            child: const Image(
              image: AssetImage('assets/images/overlays/dust_1.png'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        );
      },
    );
  }

  Widget _buildParallaxImage() {
    return ValueListenableBuilder<Offset>(
      valueListenable: widget.viewModel.offsetNotifier,
      builder: (context, offset, child) {
        return ClipRRect(
          borderRadius:
              BorderRadius.circular(widget.viewModel.backgroundBorderRadius),
          child: Transform.translate(
            offset: offset * 0.16,
            child: CollectionCardImageWidget(
              borderRadius: widget.viewModel.backgroundBorderRadius,
              imageUrl: widget.viewModel.card.imageUrl,
            ),
          ),
        );
      },
    );
  }

  Widget _buildParallaxTexts() {
    return ValueListenableBuilder<Offset>(
      valueListenable: widget.viewModel.offsetNotifier,
      builder: (context, offset, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: widget.viewModel.isDragging ? 1.0 : 0.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.translate(
                  offset: offset * 0.45,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: CollectionCardTextWidget.title(
                      text: widget.viewModel.card.title,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: offset * 0.36,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: CollectionCardTextWidget.subtitle(
                      text: widget.viewModel.card.subtitle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHashtags() {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: CollectionCardHashtagsWidget(
          hashtags: widget.viewModel.card.hashtags),
    );
  }

  Widget _buildButtons() {
    return ValueListenableBuilder<Offset>(
      valueListenable: widget.viewModel.offsetNotifier,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset * 0.02,
          child: CollectionCardButtonsRow(
            firstIconGroup: [
              CustomIconButton.small(
                icon: Icons.heart_broken_outlined,
                backgroundColor: cSurfaceColor,
                onPressed: () {},
              ),
              CustomIconButton.small(
                icon: Icons.comment_outlined,
                backgroundColor: cSurfaceColor,
                onPressed: () {},
              ),
              CustomIconButton.small(
                icon: Icons.send_outlined,
                backgroundColor: cSurfaceColor,
                onPressed: () {},
              ),
            ],
            secondIconGroup: [
              CustomIconButton.small(
                icon: Icons.bookmark_outline,
                backgroundColor: cSurfaceColor,
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
