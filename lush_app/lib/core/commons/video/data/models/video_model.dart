import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/commons/video/data/models/video_advanced_stats_model.dart';
import 'package:lush_app/core/commons/video/data/models/video_details_model.dart';
import 'package:lush_app/core/commons/video/data/models/video_metadata_model.dart';
import 'package:lush_app/core/commons/video/data/models/video_state_model.dart';
import 'package:lush_app/core/commons/video/data/models/video_user_info_model.dart';
import 'package:lush_app/core/commons/video/data/models/video_user_interactions_model.dart';
import 'package:lush_app/core/model.dart';

enum VideoModelField {
  id,
  userInfoModel,
  detailsModel,
  metadataModel,
  stateModel,
  advancedStatsModel,
  userInteractionsModel,
}

@immutable
class VideoModel extends Equatable implements BaseModel<VideoModel> {
  final String id;
  final VideoUserInfoModel userInfoModel;
  final VideoDetailsModel detailsModel;
  final VideoMetadataModel metadataModel;
  final VideoStateModel stateModel;
  final VideoAdvancedStatsModel advancedStatsModel;
  final VideoUserInteractionsModel userInteractionsModel;

  const VideoModel({
    required this.id,
    required this.userInfoModel,
    required this.detailsModel,
    required this.metadataModel,
    required this.stateModel,
    required this.advancedStatsModel,
    required this.userInteractionsModel,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => VideoModel(
        id: map[VideoModelField.id.name] as String? ?? '',
        userInfoModel: VideoUserInfoModel.fromMap(
            map[VideoModelField.userInfoModel.name] as Map<String, dynamic>? ??
                {}),
        detailsModel: VideoDetailsModel.fromMap(
            map[VideoModelField.detailsModel.name] as Map<String, dynamic>? ??
                {}),
        metadataModel: VideoMetadataModel.fromMap(
            map[VideoModelField.metadataModel.name] as Map<String, dynamic>? ??
                {}),
        stateModel: VideoStateModel.fromMap(
            map[VideoModelField.stateModel.name] as Map<String, dynamic>? ??
                {}),
        advancedStatsModel: VideoAdvancedStatsModel.fromMap(
            map[VideoModelField.advancedStatsModel.name]
                    as Map<String, dynamic>? ??
                {}),
        userInteractionsModel: VideoUserInteractionsModel.fromMap(
            map[VideoModelField.userInteractionsModel.name]
                    as Map<String, dynamic>? ??
                {}),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      VideoModelField.id.name: id,
      VideoModelField.userInfoModel.name: userInfoModel,
      VideoModelField.detailsModel.name: detailsModel,
      VideoModelField.metadataModel.name: metadataModel,
      VideoModelField.stateModel.name: stateModel,
      VideoModelField.advancedStatsModel.name: advancedStatsModel,
      VideoModelField.userInteractionsModel.name: userInteractionsModel,
    };
  }

  @override
  VideoModel copyWith({
    String? id,
    VideoUserInfoModel? userInfoModel,
    VideoDetailsModel? detailsModel,
    VideoMetadataModel? metadataModel,
    VideoStateModel? stateModel,
    VideoAdvancedStatsModel? advancedStatsModel,
    VideoUserInteractionsModel? userInteractionsModel,
  }) {
    return VideoModel(
      id: id ?? this.id,
      userInfoModel: userInfoModel ?? this.userInfoModel,
      detailsModel: detailsModel ?? this.detailsModel,
      metadataModel: metadataModel ?? this.metadataModel,
      stateModel: stateModel ?? this.stateModel,
      advancedStatsModel: advancedStatsModel ?? this.advancedStatsModel,
      userInteractionsModel:
          userInteractionsModel ?? this.userInteractionsModel,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userInfoModel,
        detailsModel,
        metadataModel,
        stateModel,
        advancedStatsModel,
        userInteractionsModel,
      ];
}
