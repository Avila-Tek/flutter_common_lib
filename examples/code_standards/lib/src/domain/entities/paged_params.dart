class PageParams {
  const PageParams({
    required this.page,
    required this.perPage,
  });

  const PageParams.empty() : this(page: 0, perPage: 0);

  final int page;
  final int perPage;

  @override
  String toString() => 'PageParams(page: $page, perPage: $perPage)';
}
