import '../error/app_error.dart';

class ResultRecord<T extends AppException, U> {
  final T? error;
  final U? value;

  const ResultRecord({this.error, this.value});

  bool hasError() => error != null;
  bool hasValue() => value != null;
  bool hasErrorOrValue() => hasError() || hasValue();
  bool hasErrorAndValue() => hasError() && hasValue();

  /// Create an error result
  static ResultRecord<T, U> returnAnError<T extends AppException, U>(T error) {
    return ResultRecord(error: error, value: null);
  }

  /// Create a success result
  static ResultRecord<T, U> returnTheValue<T extends AppException, U>(U value) {
    return ResultRecord(error: null, value: value);
  }

  /// Create a result that contains both an error and a value
  static ResultRecord<T, U> returnResultWithError<T extends AppException, U>(T error, U value) {
    return ResultRecord(error: error, value: value);
  }
}