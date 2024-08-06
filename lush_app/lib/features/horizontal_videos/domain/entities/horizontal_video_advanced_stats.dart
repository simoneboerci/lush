// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class HorizontalVideoAdvancedStats extends Equatable {
  final int averageWatchTime;
  final double completionRate;
  final Map<String, double> audienceRetention;

  const HorizontalVideoAdvancedStats({
    this.averageWatchTime = 0,
    this.completionRate = 0,
    this.audienceRetention = const {},
  });

  HorizontalVideoAdvancedStats copyWith({
    int? averageWatchTime,
    double? completionRate,
    Map<String, double>? audienceRetention,
  }) {
    return HorizontalVideoAdvancedStats(
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
