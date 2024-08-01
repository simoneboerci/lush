import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/upload_horizontal_video_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_repository.dart';

class UploadHorizontalVideoUseCase
    implements UseCase<HorizontalVideo, UploadHorizontalVideoParams> {
  final HorizontalVideoRepository horizontalVideoRepository;

  const UploadHorizontalVideoUseCase(this.horizontalVideoRepository);

  @override
  Future<Either<Failure, HorizontalVideo>> call(
      UploadHorizontalVideoParams params) async {
    return await horizontalVideoRepository.uploadHorizontalVideos(
        params.filePath, params.fileName, params.thumbnailUrl, params.title);
  }
}
