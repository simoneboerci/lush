// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class VideoFileInfo extends Equatable {
  final String fileUrl;
  final String thumbnailUrl;
  final Duration duration;
  final int size;
  final String format;
  final String resolution;

  const VideoFileInfo({
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.duration,
    required this.size,
    required this.format,
    required this.resolution,
  });

  VideoFileInfo copyWith({
    String? fileUrl,
    String? thumbnailUrl,
    Duration? duration,
    int? size,
    String? format,
    String? resolution,
  }) {
    return VideoFileInfo(
      fileUrl: fileUrl ?? this.fileUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      size: size ?? this.size,
      format: format ?? this.format,
      resolution: resolution ?? this.resolution,
    );
  }

  @override
  List<Object?> get props => [
        fileUrl,
        thumbnailUrl,
        duration,
        size,
        format,
        resolution,
      ];
}
