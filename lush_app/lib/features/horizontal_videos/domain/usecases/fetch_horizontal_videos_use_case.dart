import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/fetch_horizontal_videos_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_repository.dart';

class FetchHorizontalVideosUseCase
    implements UseCase<List<HorizontalVideo>, FetchHorizontalVideosParams> {
  final HorizontalVideoRepository horizontalVideoRepository;

  const FetchHorizontalVideosUseCase(this.horizontalVideoRepository);

  @override
  Future<Either<Failure, List<HorizontalVideo>>> call(params) async {
    return await horizontalVideoRepository.fetchVideos(
        lastDocumentId: params.lastDocumentId, pageSize: params.pageSize);
  }
}
