import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/get_horizontal_videos_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_repository.dart';

class GetHorizontalVideosUseCase
    implements UseCase<List<HorizontalVideo>, GetHorizontalVideosParams> {
  final HorizontalVideoRepository horizontalVideoRepository;

  const GetHorizontalVideosUseCase(this.horizontalVideoRepository);

  @override
  Future<Either<Failure, List<HorizontalVideo>>> call(
      GetHorizontalVideosParams params) async {
    return await horizontalVideoRepository.getHorizontalVideos(
        lastVideoId: params.lastVideoId);
  }
}
