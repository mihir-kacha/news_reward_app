part of 'pagination_helper.dart';

class PaginatedListResult<T> extends Equatable {
  const PaginatedListResult({
    required this.data,
    required this.totalCount,
    required this.hasMore,
  });

  const PaginatedListResult.empty({
    this.data = const [],
    this.totalCount = 0,
    this.hasMore = false,
  });

  final Iterable<T> data;
  final int totalCount;
  final bool hasMore;

  @override
  List<Object?> get props => [totalCount, data, hasMore];
}
