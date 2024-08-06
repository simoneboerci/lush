// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:duration/duration.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum HorizontalVideoFileInfoModelField {
  videoUrl,
  thumbnailUrl,
  duration,
  size,
  format,
  resolution,
  aspectRatio,
}

@immutable
class HorizontalVideoFileInfoModel extends Equatable
    implements BaseModel<HorizontalVideoFileInfoModel> {
  final String videoUrl;
  final String thumbnailUrl;
  final Duration duration;
  final int size;
  final String format;
  final Size resolution;
  final double aspectRatio;

  const HorizontalVideoFileInfoModel({
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.duration,
    required this.size,
    required this.format,
    required this.resolution,
    required this.aspectRatio,
  });

  factory HorizontalVideoFileInfoModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => HorizontalVideoFileInfoModel(
        videoUrl:
            map[HorizontalVideoFileInfoModelField.videoUrl.name] as String? ??
                '',
        thumbnailUrl: map[HorizontalVideoFileInfoModelField.thumbnailUrl.name]
                as String? ??
            '',
        duration: tryParseDuration(
                map[HorizontalVideoFileInfoModelField.duration.name]
                        as String? ??
                    '') ??
            Duration.zero,
        size: map[HorizontalVideoFileInfoModelField.size.name] as int? ?? 0,
        format:
            map[HorizontalVideoFileInfoModelField.format.name] as String? ?? '',
        resolution:
            map[HorizontalVideoFileInfoModelField.resolution.name] as Size? ??
                Size.zero,
        aspectRatio: map[HorizontalVideoFileInfoModelField.aspectRatio.name]
                as double? ??
            0.0,
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      HorizontalVideoFileInfoModelField.videoUrl.name: videoUrl,
      HorizontalVideoFileInfoModelField.thumbnailUrl.name: thumbnailUrl,
      HorizontalVideoFileInfoModelField.duration.name: duration.toString(),
      HorizontalVideoFileInfoModelField.size.name: size,
      HorizontalVideoFileInfoModelField.format.name: format,
      HorizontalVideoFileInfoModelField.resolution.name: resolution,
      HorizontalVideoFileInfoModelField.aspectRatio.name: aspectRatio,
    };
  }

  @override
  HorizontalVideoFileInfoModel copyWith({
    String? fileUrl,
    String? thumbnailUrl,
    Duration? duration,
    int? size,
    String? format,
    Size? resolution,
    double? aspectRatio,
  }) {
    return HorizontalVideoFileInfoModel(
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
