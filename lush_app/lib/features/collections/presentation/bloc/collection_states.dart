import 'package:equatable/equatable.dart';
import 'package:lush_app/features/collections/domain/entities/collection_card.dart';

abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object?> get props => [];
}

final class CollectionInitialState extends CollectionState {
  const CollectionInitialState();
}

final class CollectionLoadingState extends CollectionState {
  const CollectionLoadingState();
}

final class CollectionLoadedState extends CollectionState {
  final List<CollectionCard> cards;

  const CollectionLoadedState({required this.cards});

  @override
  List<Object?> get props => [cards];
}

final class CollectionErrorState extends CollectionState {
  final String message;

  const CollectionErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
