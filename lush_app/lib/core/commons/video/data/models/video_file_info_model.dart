// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:duration/duration.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum VideoFileInfoModelField {
  fileUrl,
  thumbnailUrl,
  duration,
  size,
  format,
  resolution,
}

@immutable
class VideoFileInfoModel extends Equatable
    implements BaseModel<VideoFileInfoModel> {
  final String fileUrl;
  final String thumbnailUrl;
  final Duration duration;
  final int size;
  final String format;
  final String resolution;

  const VideoFileInfoModel({
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.duration,
    required this.size,
    required this.format,
    required this.resolution,
  });

  factory VideoFileInfoModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => VideoFileInfoModel(
        fileUrl: map[VideoFileInfoModelField.fileUrl.name] as String? ?? '',
        thumbnailUrl:
            map[VideoFileInfoModelField.thumbnailUrl.name] as String? ?? '',
        duration: tryParseDuration(
                map[VideoFileInfoModelField.duration.name] as String? ?? '') ??
            Duration.zero,
        size: map[VideoFileInfoModelField.size.name] as int? ?? 0,
        format: map[VideoFileInfoModelField.format.name] as String? ?? '',
        resolution:
            map[VideoFileInfoModelField.resolution.name] as String? ?? '',
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      VideoFileInfoModelField.fileUrl.name: fileUrl,
      VideoFileInfoModelField.thumbnailUrl.name: thumbnailUrl,
      VideoFileInfoModelField.duration.name: duration.toString(),
      VideoFileInfoModelField.size.name: size,
      VideoFileInfoModelField.format.name: format,
      VideoFileInfoModelField.resolution.name: resolution,
    };
  }

  @override
  VideoFileInfoModel copyWith({
    String? fileUrl,
    String? thumbnailUrl,
    Duration? duration,
    int? size,
    String? format,
    String? resolution,
  }) {
    return VideoFileInfoModel(
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
