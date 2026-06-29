import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'paginated_list_result.dart';

abstract interface class PaginationProvider<T extends Object> {
  List<T> get list;

  bool get loading;

  bool get reachAtEnd;

  Future<void> onRefresh();

  Future<void> onLoadMore();
}
