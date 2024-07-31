import 'package:equatable/equatable.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object?> get props => [];
}

final class GetCollectionEvent extends CollectionEvent {}

final class GetCollectionCardEvent extends CollectionEvent {}
