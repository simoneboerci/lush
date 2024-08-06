final class HorizontalVideoRemoteException implements Exception {
  final String message;

  const HorizontalVideoRemoteException(this.message);

  @override
  String toString() => message;
}

final class HorizontalVideoNotFoundRemoteException
    extends HorizontalVideoRemoteException {
  const HorizontalVideoNotFoundRemoteException(super.message);
}

final class GetAllHorizontalVideosRemoteException
    extends HorizontalVideoRemoteException {
  const GetAllHorizontalVideosRemoteException(super.message);
}

final class FetchHorizontalVideosRemoteException
    extends HorizontalVideoRemoteException {
  const FetchHorizontalVideosRemoteException(super.message);
}

final class GetHorizontalVideoByIdRemoteException
    extends HorizontalVideoRemoteException {
  const GetHorizontalVideoByIdRemoteException(super.message);
}

final class UploadHorizontalVideoRemoteException
    extends HorizontalVideoRemoteException {
  const UploadHorizontalVideoRemoteException(super.message);
}

final class UpdateHorizontalVideoRemoteException
    extends HorizontalVideoRemoteException {
  const UpdateHorizontalVideoRemoteException(super.message);
}

final class DeleteHorizontalVideoException
    extends HorizontalVideoRemoteException {
  const DeleteHorizontalVideoException(super.message);
}

final class UnsupportedFileFormatException
    extends HorizontalVideoRemoteException {
  const UnsupportedFileFormatException(super.message);
}
