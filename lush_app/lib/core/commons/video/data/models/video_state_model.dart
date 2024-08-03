// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum VideoStateModelField {
  isLive,
  isArchived,
  isMonetized,
  monetizationDetails,
}

@immutable
class VideoStateModel extends Equatable implements BaseModel<VideoStateModel> {
  final bool isLive;
  final bool isArchived;
  final bool isMonetized;
  final Map<String, dynamic> monetizationDetails;

  const VideoStateModel({
    this.isLive = false,
    this.isArchived = false,
    this.isMonetized = false,
    this.monetizationDetails = const {},
  });

  factory VideoStateModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => VideoStateModel(
        isLive: map[VideoStateModelField.isLive.name] as bool? ?? false,
        isArchived: map[VideoStateModelField.isArchived.name] as bool? ?? false,
        isMonetized:
            map[VideoStateModelField.isMonetized.name] as bool? ?? false,
        monetizationDetails: map[VideoStateModelField.monetizationDetails.name]
                as Map<String, dynamic>? ??
            {},
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      VideoStateModelField.isLive.name: isLive,
      VideoStateModelField.isArchived.name: isArchived,
      VideoStateModelField.isMonetized.name: isMonetized,
      VideoStateModelField.monetizationDetails.name: monetizationDetails,
    };
  }

  @override
  VideoStateModel copyWith({
    bool? isLive,
    bool? isArchived,
    bool? isMonetized,
    Map<String, dynamic>? monetizationDetails,
  }) {
    return VideoStateModel(
      isLive: isLive ?? this.isLive,
      isArchived: isArchived ?? this.isArchived,
      isMonetized: isMonetized ?? this.isMonetized,
      monetizationDetails: monetizationDetails ?? this.monetizationDetails,
    );
  }

  @override
  List<Object?> get props => [
        isLive,
        isArchived,
        isMonetized,
        monetizationDetails,
      ];
}
