// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class HorizontalVideoState extends Equatable {
  final bool isLive;
  final bool isArchived;
  final bool isMonetized;
  final Map<String, dynamic> monetizationDetails;

  const HorizontalVideoState({
    this.isLive = false,
    this.isArchived = false,
    this.isMonetized = false,
    this.monetizationDetails = const {},
  });

  HorizontalVideoState copyWith({
    bool? isLive,
    bool? isArchived,
    bool? isMonetized,
    Map<String, dynamic>? monetizationDetails,
  }) {
    return HorizontalVideoState(
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
