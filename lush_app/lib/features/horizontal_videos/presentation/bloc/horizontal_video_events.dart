import 'package:equatable/equatable.dart';

abstract interface class HorizontalVideoEvent extends Equatable {
  const HorizontalVideoEvent();

  @override
  List<Object?> get props => [];
}

final class GetHorizontalVideosEvent extends HorizontalVideoEvent {
  const GetHorizontalVideosEvent();
}

final class GetHorizontalVideoByIdEvent extends HorizontalVideoEvent {
  final String id;

  const GetHorizontalVideoByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

final class UploadHorizontalVideoEvent extends HorizontalVideoEvent {
  final String filePath;
  final String fileName;
  final String thumbnailUrl;

  const UploadHorizontalVideoEvent({
    required this.filePath,
    required this.fileName,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [filePath, fileName, thumbnailUrl];
}
