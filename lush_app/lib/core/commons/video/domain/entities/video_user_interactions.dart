// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class VideoUserInteractions extends Equatable {
  final List<Map<String, dynamic>> userInteractions;
  final bool isFlagged;
  final List<Map<String, dynamic>> flagDetails;

  const VideoUserInteractions({
    this.userInteractions = const [],
    this.isFlagged = false,
    this.flagDetails = const [],
  });

  VideoUserInteractions copyWith({
    List<Map<String, dynamic>>? userInteractions,
    bool? isFlagged,
    List<Map<String, dynamic>>? flagDetails,
  }) {
    return VideoUserInteractions(
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
