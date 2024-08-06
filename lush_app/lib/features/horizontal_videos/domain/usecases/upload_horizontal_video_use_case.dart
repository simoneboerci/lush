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
    return await horizontalVideoRepository.uploadVideo(
      userId: params.userId,
      videoFile: params.videoFile,
      thumbnailFile: params.thumbnailFile,
      title: params.title,
      isLive: params.isLive,
      isMonetized: params.isMonetized,
      description: params.description,
      tags: params.tags,
      category: params.category,
      privacy: params.privacy,
    );
  }
}
