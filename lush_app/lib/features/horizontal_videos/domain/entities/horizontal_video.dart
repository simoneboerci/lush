import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class HorizontalVideo extends Equatable {
  final String id;
  final String url;
  final String thumbnaillUrl;

  const HorizontalVideo({
    required this.id,
    required this.url,
    required this.thumbnaillUrl,
  });

  @override
  List<Object?> get props => [id, url, thumbnaillUrl];
}
