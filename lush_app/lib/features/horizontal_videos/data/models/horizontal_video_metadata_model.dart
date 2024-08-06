// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum HorizontalVideoMetadataModelField {
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
class HorizontalVideoMetadataModel extends Equatable
    implements BaseModel<HorizontalVideoMetadataModel> {
  final DateTime uploadDate;
  final DateTime lastModifiedDate;
  final int viewsCount;
  final int likesCount;
  final int dislikesCount;
  final int commentsCount;
  final int sharesCount;
  final int addToFavoritesCount;

  const HorizontalVideoMetadataModel({
    required this.uploadDate,
    required this.lastModifiedDate,
    this.viewsCount = 0,
    this.likesCount = 0,
    this.dislikesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.addToFavoritesCount = 0,
  });

  factory HorizontalVideoMetadataModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => HorizontalVideoMetadataModel(
        uploadDate: DateTime.tryParse(
                map[HorizontalVideoMetadataModelField.uploadDate.name]
                        as String? ??
                    '') ??
            DateTime.now(),
        lastModifiedDate: DateTime.tryParse(
                map[HorizontalVideoMetadataModelField.lastModifiedDate.name]
                        as String? ??
                    '') ??
            DateTime.now(),
        viewsCount:
            map[HorizontalVideoMetadataModelField.viewsCount.name] as int? ?? 0,
        likesCount:
            map[HorizontalVideoMetadataModelField.likesCount.name] as int? ?? 0,
        dislikesCount:
            map[HorizontalVideoMetadataModelField.dislikesCount.name] as int? ??
                0,
        commentsCount:
            map[HorizontalVideoMetadataModelField.commentsCount.name] as int? ??
                0,
        sharesCount:
            map[HorizontalVideoMetadataModelField.sharesCount.name] as int? ??
                0,
        addToFavoritesCount:
            map[HorizontalVideoMetadataModelField.addToFavoritesCount.name]
                    as int? ??
                0,
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      HorizontalVideoMetadataModelField.uploadDate.name: uploadDate,
      HorizontalVideoMetadataModelField.lastModifiedDate.name: lastModifiedDate,
      HorizontalVideoMetadataModelField.viewsCount.name: viewsCount,
      HorizontalVideoMetadataModelField.likesCount.name: likesCount,
      HorizontalVideoMetadataModelField.dislikesCount.name: dislikesCount,
      HorizontalVideoMetadataModelField.commentsCount.name: commentsCount,
      HorizontalVideoMetadataModelField.sharesCount.name: sharesCount,
      HorizontalVideoMetadataModelField.addToFavoritesCount.name:
          addToFavoritesCount,
    };
  }

  @override
  HorizontalVideoMetadataModel copyWith({
    DateTime? uploadDate,
    DateTime? lastModifiedDate,
    int? viewsCount,
    int? likesCount,
    int? dislikesCount,
    int? commentsCount,
    int? sharesCount,
    int? addToFavoritesCount,
  }) {
    return HorizontalVideoMetadataModel(
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
