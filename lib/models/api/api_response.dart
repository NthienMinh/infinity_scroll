sealed class ApiResponse<T> {
  const ApiResponse();
}

class Success<T> extends ApiResponse<T> {
  final T data;

  const Success({required this.data});
}

class Fail<T> extends ApiResponse<T> {
  final String message;
  final int code;

  const Fail({required this.message, required this.code});
}

class Error<T> extends ApiResponse<T> {
  final String message;

  const Error({required this.message});
}
