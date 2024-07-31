import 'package:flutter/material.dart';
import 'package:lush_app/features/collections/domain/entities/collection_card.dart';

class CollectionGridViewItemWidget extends StatelessWidget {
  final CollectionCard card;
  final double borderRadius;
  final VoidCallback? onTap;

  const CollectionGridViewItemWidget({
    super.key,
    required this.card,
    this.borderRadius = 8.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        child: Image.network(
          card.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
