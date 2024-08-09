abstract class Result<T> {
  R whenWithResult<R>(
    R Function(ResultSuccess<T>) success,
    R Function(ResultError<T>) error,
  ) {
    if (this is ResultSuccess<T>) {
      return success(this as ResultSuccess<T>);
    } else {
      return error(this as ResultError<T>);
    }
  }
}

class ResultSuccess<T> extends Result<T> {
  final T value;
  ResultSuccess(this.value);
}

class ResultError<T> extends Result<T> {
  final Object error;
  final StackTrace stackTrace;

  ResultError(this.error, this.stackTrace);
}
