// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class VideoMetadata extends Equatable {
  final DateTime uploadDate;
  final DateTime lastModifiedDate;
  final int viewsCount;
  final int likesCount;
  final int dislikesCount;
  final int commentsCount;
  final int sharesCount;
  final int addToFavoritesCount;

  const VideoMetadata({
    required this.uploadDate,
    required this.lastModifiedDate,
    this.viewsCount = 0,
    this.likesCount = 0,
    this.dislikesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.addToFavoritesCount = 0,
  });

  VideoMetadata copyWith({
    DateTime? uploadDate,
    DateTime? lastModifiedDate,
    int? viewsCount,
    int? likesCount,
    int? dislikesCount,
    int? commentsCount,
    int? sharesCount,
    int? addToFavoritesCount,
  }) {
    return VideoMetadata(
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
        addToFavoritesCount,
      ];
}
