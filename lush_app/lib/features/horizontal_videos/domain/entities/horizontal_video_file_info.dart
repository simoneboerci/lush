// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class HorizontalVideoFileInfo extends Equatable {
  final String videoUrl;
  final String thumbnailUrl;
  final Duration duration;
  final int size;
  final String format;
  final Size resolution;
  final double aspectRatio;

  const HorizontalVideoFileInfo({
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.duration,
    required this.size,
    required this.format,
    required this.resolution,
    required this.aspectRatio,
  });

  HorizontalVideoFileInfo copyWith({
    String? fileUrl,
    String? thumbnailUrl,
    Duration? duration,
    int? size,
    String? format,
    Size? resolution,
    double? aspectRatio,
  }) {
    return HorizontalVideoFileInfo(
      videoUrl: fileUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      size: size ?? this.size,
      format: format ?? this.format,
      resolution: resolution ?? this.resolution,
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }

  @override
  List<Object?> get props => [
        videoUrl,
        thumbnailUrl,
        duration,
        size,
        format,
        resolution,
        aspectRatio,
      ];
}
