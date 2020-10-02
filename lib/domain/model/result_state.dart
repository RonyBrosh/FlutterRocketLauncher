abstract class ResultState<T> {}

class ResultStateSuccess<T> extends ResultState<T> {
  ResultStateSuccess(this.data);

  final T data;
}

class ResultStateFailure<T> extends ResultState<T> {
  ResultStateFailure(this.reason);

  final FailureReason reason;
}

enum FailureReason { NETWORK, SERVER, CLIENT, UNKNOWN }
