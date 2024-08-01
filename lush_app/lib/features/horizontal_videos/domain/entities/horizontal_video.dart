import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class HorizontalVideo extends Equatable {
  final String id;
  final String url;
  final String thumbnaillUrl;
  final String title;

  const HorizontalVideo({
    required this.id,
    required this.url,
    required this.thumbnaillUrl,
    required this.title,
  });

  @override
  List<Object?> get props => [id, url, thumbnaillUrl, title];
}
