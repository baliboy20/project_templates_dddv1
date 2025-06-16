

class AppException implements Exception {
  final dynamic message;

  AppException([this.message]);

  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}




// typedef ResultRecord<T extends AppException, U> = (T?, U?);
//
// extension ResultRecord$<T extends AppException, U> on ResultRecord<T, U> {
//   T? get error => $1; // Access record fields via $1, $2
//   U? get value => $2;
//
//   bool hasError() => $1 != null;
//   bool hasValue() => $2 != null;
//   bool hasErrorOrValue() => hasError() || hasValue();
//   bool hasErrorAndValue() => hasError() && hasValue();
//
//   /// Use to create an Error Result.
//   static ResultRecord<T, U> returnAnError<T extends AppException, U>(T error) => (error, null);
//   /// Use to create a Value Result without an error.
//   static ResultRecord<T, U> returnTheValue<T extends AppException, U>(U value) => (null, value);
//   ///Use to create an Error or notificateion with a value.
//   static ResultRecord<T, U> returnResultWithError<T extends AppException, U>(T error, U value) => (error, value);
// }
//


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



// main(){
//   ResultRecord<AppException,dynamic> result = (AppException("error"), "value");
//   print(result.hasError());
//   print(result.error);
//   print(result.value);
// }
