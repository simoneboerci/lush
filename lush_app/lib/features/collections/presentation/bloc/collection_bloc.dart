import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/features/collections/domain/params/get_collection_params.dart';
import 'package:lush_app/features/collections/domain/usecases/get_collection_card_use_case.dart';
import 'package:lush_app/features/collections/domain/usecases/get_collection_use_case.dart';
import 'package:lush_app/features/collections/presentation/bloc/collection_events.dart';
import 'package:lush_app/features/collections/presentation/bloc/collection_states.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final GetCollectionUseCase _getCollectionUseCase;
  final GetCollectionCardUseCase _getCollectionCardUseCase;

  CollectionBloc({
    required GetCollectionUseCase getCollectionUseCase,
    required GetCollectionCardUseCase getCollectionCardUseCase,
  })  : _getCollectionUseCase = getCollectionUseCase,
        _getCollectionCardUseCase = getCollectionCardUseCase,
        super(const CollectionInitialState()) {
    on<GetCollectionEvent>(_onGetCollection);
    on<GetCollectionCardEvent>(_onGetCollectionCard);
  }

  Future<void> _onGetCollection(
      GetCollectionEvent event, Emitter<CollectionState> emit) async {
    emit(const CollectionLoadingState());
    final response = await _getCollectionUseCase(const GetCollectionParams());
    response.fold(
        (failure) => emit(CollectionErrorState(message: failure.message)),
        (cards) => emit(CollectionLoadedState(cards: cards)));
  }

  Future<void> _onGetCollectionCard(
      GetCollectionCardEvent event, Emitter<CollectionState> emir) async {}
}
