// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum HorizontalVideoUserInteractionsModelField {
  userInteractions,
  isFlagged,
  flagDetails,
}

@immutable
class HorizontalVideoUserInteractionsModel extends Equatable
    implements BaseModel<HorizontalVideoUserInteractionsModel> {
  final List<Map<String, dynamic>> userInteractions;
  final bool isFlagged;
  final List<Map<String, dynamic>> flagDetails;

  const HorizontalVideoUserInteractionsModel({
    this.userInteractions = const [],
    this.isFlagged = false,
    this.flagDetails = const [],
  });

  factory HorizontalVideoUserInteractionsModel.fromMap(
      Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => HorizontalVideoUserInteractionsModel(
        userInteractions:
            map[HorizontalVideoUserInteractionsModelField.userInteractions.name]
                    as List<Map<String, dynamic>>? ??
                [],
        isFlagged: map[HorizontalVideoUserInteractionsModelField.isFlagged.name]
                as bool? ??
            false,
        flagDetails:
            map[HorizontalVideoUserInteractionsModelField.flagDetails.name]
                    as List<Map<String, dynamic>>? ??
                [],
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      HorizontalVideoUserInteractionsModelField.userInteractions.name:
          userInteractions,
      HorizontalVideoUserInteractionsModelField.isFlagged.name: isFlagged,
      HorizontalVideoUserInteractionsModelField.flagDetails.name: flagDetails,
    };
  }

  @override
  HorizontalVideoUserInteractionsModel copyWith({
    List<Map<String, dynamic>>? userInteractions,
    bool? isFlagged,
    List<Map<String, dynamic>>? flagDetails,
  }) {
    return HorizontalVideoUserInteractionsModel(
      userInteractions: userInteractions ?? this.userInteractions,
      isFlagged: isFlagged ?? this.isFlagged,
      flagDetails: flagDetails ?? this.flagDetails,
    );
  }

  @override
  List<Object?> get props => [
        userInteractions,
        isFlagged,
        flagDetails,
      ];
}
