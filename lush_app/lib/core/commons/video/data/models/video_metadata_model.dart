// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum VideoMetadataModelField {
  uploadDate,
  lastModifiedDate,
  viewsCount,
  likesCount,
  dislikesCount,
  commentsCount,
  sharesCount,
  addToFavoritesCount,
}

@immutable
class VideoMetadataModel extends Equatable
    implements BaseModel<VideoMetadataModel> {
  final DateTime uploadDate;
  final DateTime lastModifiedDate;
  final int viewsCount;
  final int likesCount;
  final int dislikesCount;
  final int commentsCount;
  final int sharesCount;
  final int addToFavoritesCount;

  const VideoMetadataModel({
    required this.uploadDate,
    required this.lastModifiedDate,
    this.viewsCount = 0,
    this.likesCount = 0,
    this.dislikesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.addToFavoritesCount = 0,
  });

  factory VideoMetadataModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => VideoMetadataModel(
        uploadDate: DateTime.tryParse(
                map[VideoMetadataModelField.uploadDate.name] as String? ??
                    '') ??
            DateTime.now(),
        lastModifiedDate: DateTime.tryParse(
                map[VideoMetadataModelField.lastModifiedDate.name] as String? ??
                    '') ??
            DateTime.now(),
        viewsCount: map[VideoMetadataModelField.viewsCount.name] as int? ?? 0,
        likesCount: map[VideoMetadataModelField.likesCount.name] as int? ?? 0,
        dislikesCount:
            map[VideoMetadataModelField.dislikesCount.name] as int? ?? 0,
        commentsCount:
            map[VideoMetadataModelField.commentsCount.name] as int? ?? 0,
        sharesCount: map[VideoMetadataModelField.sharesCount.name] as int? ?? 0,
        addToFavoritesCount:
            map[VideoMetadataModelField.addToFavoritesCount.name] as int? ?? 0,
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      VideoMetadataModelField.uploadDate.name: uploadDate,
      VideoMetadataModelField.lastModifiedDate.name: lastModifiedDate,
      VideoMetadataModelField.viewsCount.name: viewsCount,
      VideoMetadataModelField.likesCount.name: likesCount,
      VideoMetadataModelField.dislikesCount.name: dislikesCount,
      VideoMetadataModelField.commentsCount.name: commentsCount,
      VideoMetadataModelField.sharesCount.name: sharesCount,
      VideoMetadataModelField.addToFavoritesCount.name: addToFavoritesCount,
    };
  }

  @override
  VideoMetadataModel copyWith({
    DateTime? uploadDate,
    DateTime? lastModifiedDate,
    int? viewsCount,
    int? likesCount,
    int? dislikesCount,
    int? commentsCount,
    int? sharesCount,
    int? addToFavoritesCount,
  }) {
    return VideoMetadataModel(
      uploadDate: uploadDate ?? this.uploadDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      viewsCount: viewsCount ?? this.viewsCount,
      likesCount: likesCount ?? this.likesCount,
      dislikesCount: dislikesCount ?? this.dislikesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      addToFavoritesCount: addToFavoritesCount ?? this.addToFavoritesCount,
    );
  }

  @override
  List<Object?> get props => [
        uploadDate,
        lastModifiedDate,
        viewsCount,
        likesCount,
        dislikesCount,
        commentsCount,
        sharesCount,
        addToFavoritesCount,
      ];
}
