import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_advanced_stats_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_details_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_file_info_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_metadata_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_state_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_user_info_model.dart';
import 'package:lush_app/features/horizontal_videos/data/models/horizontal_video_user_interactions_model.dart';
import 'package:lush_app/core/model.dart';

enum HorizontalVideoModelField {
  id,
  userInfoModel,
  detailsModel,
  fileInfoModel,
  metadataModel,
  stateModel,
  advancedStatsModel,
  userInteractionsModel,
}

@immutable
class HorizontalVideoModel extends Equatable
    implements BaseModel<HorizontalVideoModel> {
  final String id;
  final HorizontalVideoUserInfoModel userInfoModel;
  final HorizontalVideoDetailsModel detailsModel;
  final HorizontalVideoFileInfoModel fileInfoModel;
  final HorizontalVideoMetadataModel metadataModel;
  final HorizontalVideoStateModel stateModel;
  final HorizontalVideoAdvancedStatsModel advancedStatsModel;
  final HorizontalVideoUserInteractionsModel userInteractionsModel;

  const HorizontalVideoModel({
    required this.id,
    required this.userInfoModel,
    required this.detailsModel,
    required this.fileInfoModel,
    required this.metadataModel,
    required this.stateModel,
    required this.advancedStatsModel,
    required this.userInteractionsModel,
  });

  factory HorizontalVideoModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => HorizontalVideoModel(
        id: map[HorizontalVideoModelField.id.name] as String? ?? '',
        userInfoModel: HorizontalVideoUserInfoModel.fromMap(
            map[HorizontalVideoModelField.userInfoModel.name]
                    as Map<String, dynamic>? ??
                {}),
        detailsModel: HorizontalVideoDetailsModel.fromMap(
            map[HorizontalVideoModelField.detailsModel.name]
                    as Map<String, dynamic>? ??
                {}),
        fileInfoModel: HorizontalVideoFileInfoModel.fromMap(
            map[HorizontalVideoModelField.fileInfoModel.name]
                    as Map<String, dynamic>? ??
                {}),
        metadataModel: HorizontalVideoMetadataModel.fromMap(
            map[HorizontalVideoModelField.metadataModel.name]
                    as Map<String, dynamic>? ??
                {}),
        stateModel: HorizontalVideoStateModel.fromMap(
            map[HorizontalVideoModelField.stateModel.name]
                    as Map<String, dynamic>? ??
                {}),
        advancedStatsModel: HorizontalVideoAdvancedStatsModel.fromMap(
            map[HorizontalVideoModelField.advancedStatsModel.name]
                    as Map<String, dynamic>? ??
                {}),
        userInteractionsModel: HorizontalVideoUserInteractionsModel.fromMap(
            map[HorizontalVideoModelField.userInteractionsModel.name]
                    as Map<String, dynamic>? ??
                {}),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      HorizontalVideoModelField.id.name: id,
      HorizontalVideoModelField.userInfoModel.name: userInfoModel,
      HorizontalVideoModelField.detailsModel.name: detailsModel,
      HorizontalVideoModelField.fileInfoModel.name: fileInfoModel,
      HorizontalVideoModelField.metadataModel.name: metadataModel,
      HorizontalVideoModelField.stateModel.name: stateModel,
      HorizontalVideoModelField.advancedStatsModel.name: advancedStatsModel,
      HorizontalVideoModelField.userInteractionsModel.name:
          userInteractionsModel,
    };
  }

  @override
  HorizontalVideoModel copyWith({
    String? id,
    HorizontalVideoUserInfoModel? userInfoModel,
    HorizontalVideoDetailsModel? detailsModel,
    HorizontalVideoFileInfoModel? fileInfoModel,
    HorizontalVideoMetadataModel? metadataModel,
    HorizontalVideoFileInfoModel? infoModel,
    HorizontalVideoStateModel? stateModel,
    HorizontalVideoAdvancedStatsModel? advancedStatsModel,
    HorizontalVideoUserInteractionsModel? userInteractionsModel,
  }) {
    return HorizontalVideoModel(
      id: id ?? this.id,
      userInfoModel: userInfoModel ?? this.userInfoModel,
      detailsModel: detailsModel ?? this.detailsModel,
      fileInfoModel: fileInfoModel ?? this.fileInfoModel,
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
        fileInfoModel,
        metadataModel,
        stateModel,
        advancedStatsModel,
        userInteractionsModel,
      ];
}
