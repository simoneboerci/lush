import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum HorizontalVideoAdvancedStatsModelField {
  averageWatchTime,
  completionRate,
  audienceRetention,
}

@immutable
class HorizontalVideoAdvancedStatsModel extends Equatable
    implements BaseModel<HorizontalVideoAdvancedStatsModel> {
  final int averageWatchTime;
  final double completionRate;
  final Map<String, double> audienceRetention;

  const HorizontalVideoAdvancedStatsModel({
    this.averageWatchTime = 0,
    this.completionRate = 0,
    this.audienceRetention = const {},
  });

  factory HorizontalVideoAdvancedStatsModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => HorizontalVideoAdvancedStatsModel(
        averageWatchTime:
            map[HorizontalVideoAdvancedStatsModelField.averageWatchTime.name]
                    as int? ??
                0,
        completionRate:
            map[HorizontalVideoAdvancedStatsModelField.completionRate.name]
                    as double? ??
                0.0,
        audienceRetention:
            map[HorizontalVideoAdvancedStatsModelField.audienceRetention.name]
                    as Map<String, double>? ??
                {},
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      HorizontalVideoAdvancedStatsModelField.averageWatchTime.name:
          averageWatchTime,
      HorizontalVideoAdvancedStatsModelField.completionRate.name:
          completionRate,
      HorizontalVideoAdvancedStatsModelField.audienceRetention.name:
          audienceRetention,
    };
  }

  @override
  HorizontalVideoAdvancedStatsModel copyWith({
    int? averageWatchTime,
    double? completionRate,
    Map<String, double>? audienceRetention,
  }) {
    return HorizontalVideoAdvancedStatsModel(
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
