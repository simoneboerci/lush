import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/get_horizontal_video_by_id_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/get_horizontal_videos_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/upload_horizontal_video_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/usecases/get_horizontal_video_by_id_use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/usecases/get_horizontal_videos_use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/usecases/upload_horizontal_video_use_case.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_events.dart';
import 'package:lush_app/features/horizontal_videos/presentation/bloc/horizontal_video_states.dart';

class HorizontalVideoBloc
    extends Bloc<HorizontalVideoEvent, HorizontalVideoState> {
  final GetHorizontalVideosUseCase _getHorizontalVideosUseCase;
  final GetHorizontalVideoByIdUseCase _getHorizontalVideoByIdUseCase;
  final UploadHorizontalVideoUseCase _uploadHorizontalVideoUseCase;

  final List<HorizontalVideo> _allVideos = [];
  String? _lastVideoId;
  bool _hasReachedEnd = false;

  HorizontalVideoBloc({
    required GetHorizontalVideosUseCase getHorizontalVideosUseCase,
    required GetHorizontalVideoByIdUseCase getHorizontalVideoByIdUseCase,
    required UploadHorizontalVideoUseCase uploadHorizontalVideoUseCase,
  })  : _getHorizontalVideosUseCase = getHorizontalVideosUseCase,
        _getHorizontalVideoByIdUseCase = getHorizontalVideoByIdUseCase,
        _uploadHorizontalVideoUseCase = uploadHorizontalVideoUseCase,
        super(const HorizontalVideoInitalState()) {
    on<GetHorizontalVideosEvent>(_onGetHorizontalVideos);
    on<GetHorizontalVideoByIdEvent>(_onGetHorizontalVideoById);
    on<UploadHorizontalVideoEvent>(_onUploadHorizontalVideo);
  }

  Future<void> _onGetHorizontalVideos(GetHorizontalVideosEvent event,
      Emitter<HorizontalVideoState> emit) async {
    if (_hasReachedEnd) return;

    if (_allVideos.isEmpty) {
      emit(const HorizontalVideosLoadingState());
    } else {
      emit(HorizontalVideosLoadingMoreState(_allVideos));
    }

    final response = await _getHorizontalVideosUseCase(
        GetHorizontalVideosParams(lastVideoId: _lastVideoId));

    response.fold((failure) {
      emit(HorizontalVideoErrorState(failure.message));
    }, (newVideos) {
      _allVideos.addAll(newVideos);
      _lastVideoId = newVideos.isNotEmpty ? newVideos.last.id : null;
      _hasReachedEnd =
          newVideos.length < 10; // Assuming page size is a predefined variable
      emit(HorizontalVideosLoadedState(_allVideos));
    });
  }

  Future<void> _onGetHorizontalVideoById(GetHorizontalVideoByIdEvent event,
      Emitter<HorizontalVideoState> emit) async {
    emit(const HorizontalVideoLoadingState());

    final response = await _getHorizontalVideoByIdUseCase(
        GetHorizontalVideoByIdParams(event.id));

    response.fold((failure) => emit(HorizontalVideoErrorState(failure.message)),
        (horizontalVideo) => emit(HorizontalVideoLoadedState(horizontalVideo)));
  }

  Future<void> _onUploadHorizontalVideo(UploadHorizontalVideoEvent event,
      Emitter<HorizontalVideoState> emit) async {
    emit(const HorizontalVideoUploadingState());

    final response =
        await _uploadHorizontalVideoUseCase(UploadHorizontalVideoParams(
      filePath: event.filePath,
      fileName: event.fileName,
      thumbnailUrl: event.thumbnailUrl,
      title: event.title,
    ));

    response.fold(
        (failure) => emit(HorizontalVideoErrorState(failure.message)),
        (horizontalVideo) =>
            emit(HorizontalVideoUploadedState(horizontalVideo)));
  }
}
