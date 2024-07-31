import 'package:equatable/equatable.dart';

enum CollectionCardModelField {
  id,
  title,
  subtitle,
  imageUrl,
  hashtags,
}

class CollectionCardModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final List<String> hashtags;

  const CollectionCardModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.hashtags = const [],
  });

  factory CollectionCardModel.fromMap(Map<String, dynamic> map) {
    return CollectionCardModel(
      id: map[CollectionCardModelField.id.name] as String? ?? '',
      title: map[CollectionCardModelField.title.name] as String? ?? '',
      subtitle: map[CollectionCardModelField.subtitle.name] as String? ?? '',
      imageUrl: map[CollectionCardModelField.imageUrl.name] as String? ?? '',
      hashtags: List<String>.from(map[CollectionCardModelField.hashtags.name])
              as List<String>? ??
          [],
    );
  }

  Map<String, dynamic> toMap({
    String? id,
    String? title,
    String? subtitle,
    String? imageUrl,
    List<String>? hashtags,
  }) {
    return {
      CollectionCardModelField.id.name: id ?? this.id,
      CollectionCardModelField.title.name: title ?? this.title,
      CollectionCardModelField.subtitle.name: subtitle ?? this.subtitle,
      CollectionCardModelField.imageUrl.name: imageUrl ?? this.id,
      CollectionCardModelField.hashtags.name: hashtags ?? this.hashtags,
    };
  }

  @override
  List<Object?> get props => [id, title, subtitle, imageUrl, hashtags];
}
