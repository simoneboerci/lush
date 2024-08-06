import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/update_horizontal_video_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_repository.dart';

class UpdateHorizontalVideoUseCase
    implements UseCase<HorizontalVideo, UpdateHorizontalVideoParams> {
  final HorizontalVideoRepository horizontalVideoRepository;

  const UpdateHorizontalVideoUseCase(this.horizontalVideoRepository);

  @override
  Future<Either<Failure, HorizontalVideo>> call(
      UpdateHorizontalVideoParams params) async {
    return await horizontalVideoRepository.updateVideo(params.horizontalVideo);
  }
}
