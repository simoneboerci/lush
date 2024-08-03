// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lush_app/core/model.dart';

enum VideoUserInteractionsModelField {
  userInteractions,
  isFlagged,
  flagDetails,
}

@immutable
class VideoUserInteractionsModel extends Equatable
    implements BaseModel<VideoUserInteractionsModel> {
  final List<Map<String, dynamic>> userInteractions;
  final bool isFlagged;
  final List<Map<String, dynamic>> flagDetails;

  const VideoUserInteractionsModel({
    this.userInteractions = const [],
    this.isFlagged = false,
    this.flagDetails = const [],
  });

  factory VideoUserInteractionsModel.fromMap(Map<String, dynamic> map) {
    return BaseModel.fromMap(
      map,
      (m) => VideoUserInteractionsModel(
        userInteractions:
            map[VideoUserInteractionsModelField.userInteractions.name]
                    as List<Map<String, dynamic>>? ??
                [],
        isFlagged:
            map[VideoUserInteractionsModelField.isFlagged.name] as bool? ??
                false,
        flagDetails: map[VideoUserInteractionsModelField.flagDetails.name]
                as List<Map<String, dynamic>>? ??
            [],
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      VideoUserInteractionsModelField.userInteractions.name: userInteractions,
      VideoUserInteractionsModelField.isFlagged.name: isFlagged,
      VideoUserInteractionsModelField.flagDetails.name: flagDetails,
    };
  }

  @override
  VideoUserInteractionsModel copyWith({
    List<Map<String, dynamic>>? userInteractions,
    bool? isFlagged,
    List<Map<String, dynamic>>? flagDetails,
  }) {
    return VideoUserInteractionsModel(
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
