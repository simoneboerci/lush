import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/delete_horizontal_video_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/fetch_horizontal_videos_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/get_all_horizontal_videos_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/get_horizontal_video_by_id_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/update_horizontal_video_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/upload_horizontal_video_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/usecases/delete_horizontal_video_use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/usecases/fetch_horizontal_videos_use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/usecases/get_all_horizontal_videos_use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/usecases/get_horizontal_video_by_id_use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/usecases/update_horizontal_video_use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/usecases/upload_horizontal_video_use_case.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_list_events.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_list_states.dart';

class HorizontalVideoListBloc
    extends Bloc<HorizontalVideoListEvent, HorizontalVideoListState> {
  final GetAllHorizontalVideosUseCase _getAllHorizontalVideosUseCase;
  final FetchHorizontalVideosUseCase _fetchHorizontalVideosUseCase;
  final GetHorizontalVideoByIdUseCase _getHorizontalVideoByIdUseCase;
  final UploadHorizontalVideoUseCase _uploadHorizontalVideoUseCase;
  final UpdateHorizontalVideoUseCase _updateHorizontalVideoUseCase;
  final DeleteHorizontalVideoUseCase _deleteHorizontalVideoUseCase;

  HorizontalVideoListBloc({
    required GetAllHorizontalVideosUseCase getAllHorizontalVideoUseCase,
    required FetchHorizontalVideosUseCase fetchHorizontalVideosUseCase,
    required GetHorizontalVideoByIdUseCase getHorizontalVideoByIdUseCase,
    required UploadHorizontalVideoUseCase uploadHorizontalVideoUseCase,
    required UpdateHorizontalVideoUseCase updateHorizontalVideoUseCase,
    required DeleteHorizontalVideoUseCase deleteHorizontalVideoUseCase,
  })  : _getAllHorizontalVideosUseCase = getAllHorizontalVideoUseCase,
        _fetchHorizontalVideosUseCase = fetchHorizontalVideosUseCase,
        _getHorizontalVideoByIdUseCase = getHorizontalVideoByIdUseCase,
        _uploadHorizontalVideoUseCase = uploadHorizontalVideoUseCase,
        _updateHorizontalVideoUseCase = updateHorizontalVideoUseCase,
        _deleteHorizontalVideoUseCase = deleteHorizontalVideoUseCase,
        super(const HorizontalVideoListInitialState()) {
    on<HorizontalVideoListGetAllVideosEvent>(
        _onHorizontalVideoListGetAllVideos);
    on<HorizontalVideoListFetchVideosEvent>(_onHorizontalVideoListFetchVideos);
    on<HorizontalVideoListRefreshVideosEvent>(
        _onHorizontalVideoListRefreshVideos);
    on<HorizontalVideoListGetVideoByIdEvent>(
        _onHorizontalVideoListGetVideoById);
    on<HorizontalVideoListUploadVideoEvent>(_onHorizontalVideoListUploadVideo);
    on<HorizontalVideoListUpdateVideoEvent>(_onHorizontalVideoListUpdateVideo);
    on<HorizontalVideoListDeleteVideoEvent>(_onHorizontalVideoListDeleteVideo);
    on<HorizontalVideoListClearEvent>(_onHorizontalVideoListClear);
    on<HorizontalVideoListFilterEvent>(_onHorizontalVideoListFilter);
    on<HorizontalVideoListSortEvent>(_onHorizontalVideoListSort);
  }

  Future<void> _onHorizontalVideoListGetAllVideos(
      HorizontalVideoListGetAllVideosEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    emit(const HorizontalVideoListLoadingState());

    final response =
        await _getAllHorizontalVideosUseCase(GetAllHorizontalVideosParams());

    response.fold(
        (failure) => emit(HorizontalVideoListErrorState(failure.message)),
        (videos) => emit(HorizontalVideoListLoadedState(videos)));
  }

  Future<void> _onHorizontalVideoListFetchVideos(
      HorizontalVideoListFetchVideosEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    emit(const HorizontalVideoListPaginationLoadingState());

    final response =
        await _fetchHorizontalVideosUseCase(FetchHorizontalVideosParams(
      lastDocumentId: event.lastDocumentId,
      pageSize: event.pageSize,
    ));

    response.fold(
        (failure) =>
            emit(HorizontalVideoListPaginationErrorState(failure.message)),
        (additionalVideos) =>
            emit(HorizontalVideoListPaginationLoadedState(additionalVideos)));
  }

  Future<void> _onHorizontalVideoListRefreshVideos(
      HorizontalVideoListRefreshVideosEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    //TODO: Da implementare
  }

  Future<void> _onHorizontalVideoListGetVideoById(
      HorizontalVideoListGetVideoByIdEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    emit(const HorizontalVideoListGettingItemState());

    final response = await _getHorizontalVideoByIdUseCase(
        GetHorizontalVideoByIdParams(event.id));

    response.fold(
        (failure) => emit(HorizontalVideoListErrorState(failure.message)),
        (video) => emit(HorizontalVideoListItemGotState(video)));
  }

  Future<void> _onHorizontalVideoListUploadVideo(
      HorizontalVideoListUploadVideoEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    emit(const HorizontalVideoListAddingItemState());

    final response =
        await _uploadHorizontalVideoUseCase(UploadHorizontalVideoParams(
      userId: event.userId,
      videoFile: event.videoFile,
      thumbnailFile: event.thumbnailFile,
      title: event.title,
      isLive: event.isLive,
      isMonetized: event.isMonetized,
    ));

    response.fold(
        (failure) => emit(HorizontalVideoListErrorState(failure.message)),
        (video) => emit(HorizontalVideoListItemAddedState(video)));
  }

  Future<void> _onHorizontalVideoListUpdateVideo(
      HorizontalVideoListUpdateVideoEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    emit(const HorizontalVideoListUpdatingItemState());

    final response = await _updateHorizontalVideoUseCase(
        UpdateHorizontalVideoParams(event.horizontalVideo));

    response.fold(
        (failure) => emit(HorizontalVideoListErrorState(failure.message)),
        (video) => emit(HorizontalVideoListItemUpdatedState(video)));
  }

  Future<void> _onHorizontalVideoListDeleteVideo(
      HorizontalVideoListDeleteVideoEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    emit(const HorizontalVideoListRemovingItemState());

    final response = await _deleteHorizontalVideoUseCase(
        DeleteHorizontalVideoParams(event.id));

    response.fold(
        (failure) => emit(HorizontalVideoListErrorState(failure.message)),
        (video) => emit(HorizontalVideoListItemRemovedState(video)));
  }

  Future<void> _onHorizontalVideoListClear(HorizontalVideoListClearEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    //TODO: Da implementare
  }

  Future<void> _onHorizontalVideoListFilter(
      HorizontalVideoListFilterEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    //TODO: Da implementare
  }

  Future<void> _onHorizontalVideoListSort(HorizontalVideoListSortEvent event,
      Emitter<HorizontalVideoListState> emit) async {
    //TODO: Da implementare
  }
}
