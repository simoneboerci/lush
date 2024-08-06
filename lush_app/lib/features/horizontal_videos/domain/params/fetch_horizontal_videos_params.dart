class FetchHorizontalVideosParams {
  final String? lastDocumentId;
  final int pageSize;

  const FetchHorizontalVideosParams({
    this.lastDocumentId,
    this.pageSize = 20,
  });
}
