import 'package:fpdart/fpdart.dart';
import 'package:lush_app/core/failure.dart';
import 'package:lush_app/core/use_case.dart';
import 'package:lush_app/features/horizontal_videos/domain/entities/horizontal_video.dart';
import 'package:lush_app/features/horizontal_videos/domain/params/get_horizontal_video_by_id_params.dart';
import 'package:lush_app/features/horizontal_videos/domain/repositories/horizontal_video_repository.dart';

class GetHorizontalVideoByIdUseCase
    implements UseCase<HorizontalVideo, GetHorizontalVideoByIdParams> {
  final HorizontalVideoRepository horizontalVideoRepository;

  const GetHorizontalVideoByIdUseCase(this.horizontalVideoRepository);

  @override
  Future<Either<Failure, HorizontalVideo>> call(
      GetHorizontalVideoByIdParams params) async {
    return await horizontalVideoRepository.getHorizontalVideoById(params.id);
  }
}
