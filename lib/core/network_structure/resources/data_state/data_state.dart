import '../../../../shared/models/pagination.dart';
import '../errors/error_model.dart';

abstract class DataState<T> {
  final T? data;
  final T? searchData;
  final Pagination? pagination;
  final ErrorModel? error;
  final String? message;

  const DataState({
    this.data,
    this.pagination,
    this.error,
    this.message,
    this.searchData,
  });

  @override
  String toString() {
    return 'DataState{data: $data, searchData: $searchData, pagination: $pagination, error: $error, message: $message}';
  }
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(
    T? data, {
    super.message,
    super.searchData,
    super.pagination,
  }) : super(
          data: data,
        );
}

class DataFailed<T> extends DataState<T> {
  DataFailed(ErrorModel error) : super(error: error, message: error.title);
}

class DataInitial<T> extends DataState<T> {
  DataInitial({super.data});
}

class DataLoading<T> extends DataState<T> {
  const DataLoading({super.data});
}

class DataSearchLoading<T> extends DataState<T> {
  const DataSearchLoading() : super();
}
