part of 'pagination_helper.dart';

class PaginatedListResult<T> extends Equatable {
  const PaginatedListResult({
    required this.data,
    this.totalCount,
    this.lastDocument,
    this.latestDocument,
    required this.hasMore,
  });

  const PaginatedListResult.empty({
    this.data = const [],
    this.totalCount,
    this.lastDocument,
    this.latestDocument,
    this.hasMore = false,
  });

  final Iterable<T> data;
  final int? totalCount;
  final DocumentSnapshot? lastDocument;
  final DocumentSnapshot? latestDocument;
  final bool hasMore;

  @override
  List<Object?> get props => [lastDocument, totalCount, latestDocument, data, hasMore];
}
