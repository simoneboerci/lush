import 'dart:io';

class UploadHorizontalVideoParams {
  final String userId;
  final File videoFile;
  final File thumbnailFile;
  final String title;
  final String description;
  final List<String> tags;
  final String category;
  final String privacy;
  final bool isLive;
  final bool isMonetized;

  const UploadHorizontalVideoParams({
    required this.userId,
    required this.videoFile,
    required this.thumbnailFile,
    required this.title,
    this.description = '',
    this.tags = const [],
    this.category = '',
    this.privacy = '',
    required this.isLive,
    required this.isMonetized,
  });
}
