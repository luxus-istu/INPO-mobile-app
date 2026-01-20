sealed class DataState<T> {
  final T? data;
  final Exception? error;

  const DataState({this.data, this.error});

  factory DataState.success(T data) {
    return DataSuccess(data);
  }

  factory DataState.failure(Exception e) {
    return DataFailed(e);
  }

  R _defaultFunction<R>() {
    throw UnimplementedError('Default null handler is not implemented');
  }

  R when<R>({
    required R Function(T data) success,
    required R Function(Exception error) failure,
    R Function()? dataIsNull,
  }) {
    return switch (this) {
      DataSuccess(:final data) => success(data!),
      DataFailed(:final error) => failure(error!),
      DataIsNull() => dataIsNull?.call() ?? _defaultFunction(),
    };
  }

  void whenVoid({
    required void Function(T data) success,
    required void Function(Exception error) failure,
    required void Function() dataIsNull,
  }) {
    switch (this) {
      case DataSuccess(:final data):
        success(data!);
      case DataFailed(:final error):
        failure(error!);
      case DataIsNull():
        dataIsNull();
    }
  }

  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(Exception error)? failure,
    R Function()? dataIsNull,
  }) {
    return switch (this) {
      DataSuccess(:final data) => success?.call(data!),
      DataFailed(:final error) => failure?.call(error!),
      DataIsNull() => dataIsNull?.call(),
    };
  }

  R whenOrDefault<R>({
    R Function(T data)? success,
    R Function(Exception error)? failure,
    R Function()? dataIsNull,
    required R defaultValue,
  }) {
    return switch (this) {
      DataSuccess(:final data) => success?.call(data!) ?? defaultValue,
      DataFailed(:final error) => failure?.call(error!) ?? defaultValue,
      DataIsNull() => dataIsNull?.call() ?? defaultValue,
    };
  }
}

final class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

final class DataFailed<T> extends DataState<T> {
  const DataFailed(Exception error) : super(error: error);
}

final class DataIsNull<T> extends DataState<T> {
  const DataIsNull();
}
