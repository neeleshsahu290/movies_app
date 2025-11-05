/// Result class will be used to hold result of network call which can be
/// success (with data) or failure (with error information)
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Result<T> {
  final String message;
  const Error(this.message);
}

extension ResultWhen<T> on Result<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    switch (this) {
      case Success<T> successResult:
        return success(successResult.data);
      case Error<T> errorResult:
        return error(errorResult.message);
    }
  }
}