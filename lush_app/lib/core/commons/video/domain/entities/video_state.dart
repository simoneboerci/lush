// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class VideoState extends Equatable {
  final bool isLive;
  final bool isArchived;
  final bool isMonetized;
  final Map<String, dynamic> monetizationDetails;

  const VideoState({
    this.isLive = false,
    this.isArchived = false,
    this.isMonetized = false,
    this.monetizationDetails = const {},
  });

  VideoState copyWith({
    bool? isLive,
    bool? isArchived,
    bool? isMonetized,
    Map<String, dynamic>? monetizationDetails,
  }) {
    return VideoState(
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
