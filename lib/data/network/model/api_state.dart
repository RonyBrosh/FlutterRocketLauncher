abstract class ApiState<T> {}

class ApiStateSuccess<T> extends ApiState<T> {
  ApiStateSuccess(this.data);

  final T data;
}

class ApiStateFailure<T> extends ApiState<T> {
  ApiStateFailure(this.errorCode);

  final int errorCode;
}

const int API_ERROR_CODE_UNKNOWN = -1000;
const int API_ERROR_CODE_NETWORK = -1001;
