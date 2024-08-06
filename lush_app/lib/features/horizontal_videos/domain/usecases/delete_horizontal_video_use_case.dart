import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/delete_horizontal_video_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_repository.dart';

class DeleteHorizontalVideoUseCase
    implements UseCase<HorizontalVideo, DeleteHorizontalVideoParams> {
  final HorizontalVideoRepository horizontalVideoRepository;

  const DeleteHorizontalVideoUseCase(this.horizontalVideoRepository);

  @override
  Future<Either<Failure, HorizontalVideo>> call(
      DeleteHorizontalVideoParams params) async {
    return await horizontalVideoRepository.deleteVideo(params.id);
  }
}
