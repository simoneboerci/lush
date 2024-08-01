final class HorizontalVideoException implements Exception {
  final String message;

  const HorizontalVideoException(this.message);
}

final class HorizontalVideoNotFoundException extends HorizontalVideoException {
  const HorizontalVideoNotFoundException(super.message);
}

final class GetHorizontalVideosException extends HorizontalVideoException {
  const GetHorizontalVideosException(super.message);
}

final class GetHorizontalVideoException extends HorizontalVideoException {
  const GetHorizontalVideoException(super.message);
}

final class UploadHorizontalVideoThumbnailException
    extends HorizontalVideoException {
  const UploadHorizontalVideoThumbnailException(super.message);
}

final class UploadHorizontalVideoException extends HorizontalVideoException {
  const UploadHorizontalVideoException(super.message);
}
