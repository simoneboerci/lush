// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum HorizontalVideoStateModelField {
  isLive,
  isArchived,
  isMonetized,
  monetizationDetails,
}

@immutable
class HorizontalVideoStateModel extends Equatable
    implements BaseModel<HorizontalVideoStateModel> {
  final bool isLive;
  final bool isArchived;
  final bool isMonetized;
  final Map<String, dynamic> monetizationDetails;

  const HorizontalVideoStateModel({
    this.isLive = false,
    this.isArchived = false,
    this.isMonetized = false,
    this.monetizationDetails = const {},
  });

  factory HorizontalVideoStateModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => HorizontalVideoStateModel(
        isLive:
            map[HorizontalVideoStateModelField.isLive.name] as bool? ?? false,
        isArchived:
            map[HorizontalVideoStateModelField.isArchived.name] as bool? ??
                false,
        isMonetized:
            map[HorizontalVideoStateModelField.isMonetized.name] as bool? ??
                false,
        monetizationDetails:
            map[HorizontalVideoStateModelField.monetizationDetails.name]
                    as Map<String, dynamic>? ??
                {},
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      HorizontalVideoStateModelField.isLive.name: isLive,
      HorizontalVideoStateModelField.isArchived.name: isArchived,
      HorizontalVideoStateModelField.isMonetized.name: isMonetized,
      HorizontalVideoStateModelField.monetizationDetails.name:
          monetizationDetails,
    };
  }

  @override
  HorizontalVideoStateModel copyWith({
    bool? isLive,
    bool? isArchived,
    bool? isMonetized,
    Map<String, dynamic>? monetizationDetails,
  }) {
    return HorizontalVideoStateModel(
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
