import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum VideoAdvancedStatsModelField {
  averageWatchTime,
  completionRate,
  audienceRetention,
}

@immutable
class VideoAdvancedStatsModel extends Equatable
    implements BaseModel<VideoAdvancedStatsModel> {
  final int averageWatchTime;
  final double completionRate;
  final Map<String, double> audienceRetention;

  const VideoAdvancedStatsModel({
    this.averageWatchTime = 0,
    this.completionRate = 0,
    this.audienceRetention = const {},
  });

  factory VideoAdvancedStatsModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => VideoAdvancedStatsModel(
        averageWatchTime:
            map[VideoAdvancedStatsModelField.averageWatchTime.name] as int? ??
                0,
        completionRate:
            map[VideoAdvancedStatsModelField.completionRate.name] as double? ??
                0.0,
        audienceRetention:
            map[VideoAdvancedStatsModelField.audienceRetention.name]
                    as Map<String, double>? ??
                {},
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      VideoAdvancedStatsModelField.averageWatchTime.name: averageWatchTime,
      VideoAdvancedStatsModelField.completionRate.name: completionRate,
      VideoAdvancedStatsModelField.audienceRetention.name: audienceRetention,
    };
  }

  @override
  VideoAdvancedStatsModel copyWith({
    int? averageWatchTime,
    double? completionRate,
    Map<String, double>? audienceRetention,
  }) {
    return VideoAdvancedStatsModel(
      averageWatchTime: averageWatchTime ?? this.averageWatchTime,
      completionRate: completionRate ?? this.completionRate,
      audienceRetention: audienceRetention ?? this.audienceRetention,
    );
  }

  @override
  List<Object?> get props => [
        averageWatchTime,
        completionRate,
        audienceRetention,
      ];
}
