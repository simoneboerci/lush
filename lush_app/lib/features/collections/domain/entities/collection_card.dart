import 'package:equatable/equatable.dart';

class CollectionCard extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final List<String> hashtags;

  const CollectionCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.hashtags = const [],
  });

  @override
  List<Object?> get props => [id, title, subtitle, imageUrl, hashtags];
}
