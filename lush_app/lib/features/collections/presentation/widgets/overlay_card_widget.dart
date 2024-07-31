import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/widgets/custom_icon_button.dart';
import 'package:lush_app/core/commons/widgets/custom_text.dart';
import 'package:lush_app/core/constants/colors.dart';
import 'package:lush_app/features/collections/domain/entities/collection_card.dart';

class OverlayCardWidget extends StatelessWidget {
  final CollectionCard card;
  final double widthOverlayFactor;
  final double heightOverlayFactor;
  final Color backgroundColor;
  final double backgroundBorderRadius;

  const OverlayCardWidget({
    super.key,
    required this.card,
    this.widthOverlayFactor = 0.95,
    this.heightOverlayFactor = 0.75,
    this.backgroundColor = const Color.fromARGB(255, 23, 23, 23),
    this.backgroundBorderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * widthOverlayFactor,
      height: screenSize.height * heightOverlayFactor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(backgroundBorderRadius),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.amber,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                card.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: CustomText(
                            text: card.title,
                            fontSize: 72.0,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            shadows: const [
                              Shadow(
                                offset: Offset(0.0, 2.0),
                                blurRadius: 4.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(0.0, -2.0),
                                blurRadius: 4.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(2.0, 0.0),
                                blurRadius: 4.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(-2.0, 0.0),
                                blurRadius: 4.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(0.0, 16.0),
                                blurRadius: 42.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: CustomText(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            text: card.subtitle,
                            fontSize: 30.0,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                            textOverflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            shadows: const [
                              Shadow(
                                offset: Offset(0.0, 1.0),
                                blurRadius: 4.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(0.0, -1.0),
                                blurRadius: 4.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(1.0, 0.0),
                                blurRadius: 4.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(-1.0, 0.0),
                                blurRadius: 4.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(0.0, 8.0),
                                blurRadius: 42.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: CustomText(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                text: '#${card.hashtags.join(' #')}',
                fontSize: 16.0,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                color: Colors.amber,
              ),
            ),
            _buildButtons(),
            const SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
          ),
          CustomIconButton.small(
            icon: Icons.bookmark_outline,
            backgroundColor: cSurfaceColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
