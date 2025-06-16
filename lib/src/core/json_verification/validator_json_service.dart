

class JsonValidation {
  dynamic _altValue;
  final Map<String, dynamic> _fragment;
  final String _key;
  Object? _value;

  JsonValidation({
    dynamic altValue,
    required Map<String, dynamic> fragment,
    required String key,
  })  : _fragment = fragment,
        _key = key,
        assert(altValue != null && key != null && fragment != null) {
    _value = fragment.containsKey(key) ? fragment[key] : altValue;
    if (_value == null) {
      throw ValidationException(
          "Key not found and no alternative value provided: '$key'");
    }
  }

  /// Factory constructor to create an instance of `ValidateJson`.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> json = {"isCorrect": true};
  /// ValidateJson validator = ValidateJson.inst(fragment: json, key: "isCorrect");
  /// ```
  factory JsonValidation.inst({
    dynamic altValue,
    required Map<String, dynamic> fragment,
    required String key,
  }) {
    return JsonValidation._(
      altValue: altValue,
      fragment: fragment,
      key: key,
    );
  }

  JsonValidation._({
    dynamic altValue,
    required Map<String, dynamic> fragment,
    required String key,
  })  : _altValue = altValue,
        _fragment = fragment,
        _key = key,
        assert(key != null && fragment != null) {
    _value = fragment.containsKey(key) ? fragment[key] : altValue;
    if (_value == null) {
      throw ValidationException(
          "Key not found and no alternative value provided: '$key'");
    }
  }

  dynamic get value {
    final value = _value;
    _value = null;
    return value;
  }

  /// Validates if the value is a number.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "percentage").isNumber().value;
  /// ```
  JsonValidation isNumber() {
    if (_value is! num)
      throw ValidationException("Expected number, got: $_value");
    return this;
  }

  /// Validates if the value is an integer.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "count").isInt().value;
  /// ```
  JsonValidation isInt() {
    if (_value is! int) throw ValidationException("Expected int, got: $_value");
    return this;
  }

  /// Validates if the value is a double.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "percentage").isDouble().value;
  /// ```
  JsonValidation isDouble() {
    if (_value is! double)
      throw ValidationException("Expected double, got: $_value");
    return this;
  }

  /// Validates if the value is a string.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "answer").isString().value;
  /// ```
  JsonValidation isString() {
    if (_value is! String)
      throw ValidationException("Expected string, got: $_value");
    return this;
  }

  /// Validates if the value is a boolean.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "isCorrect").isBool().value;
  /// ```
  JsonValidation isBool() {
    if (_value is bool)
      throw ValidationException("Expected bool, got: $_value");
    return this;
  }

  /// Validates if the value is a list.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "items").isList().value;
  /// ```
  JsonValidation isList() {
    if (_value is! List)
      throw ValidationException("Expected list, got: $_value");
    return this;
  }

  /// Validates if the value is a map.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "data").isMap().value;
  /// ```
  JsonValidation isMap<K, V>() {
    if (_value is! Map<K, V>)
      throw ValidationException(
          "Expected Map<$K $V>, got: $_value  of type ${_value.runtimeType}");
    return this;
  }

  /// Validates if the value is not null.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "answer").isNotNull().value;
  /// ```
  JsonValidation isNotNull() {
    if (_value == null) throw ValidationException("Value is null");
    return this;
  }

  /// Validates if the value is a DateTime object.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "createdOn").isDateTime().value;
  /// ```
  JsonValidation isDateTime() {
    if (_value is! DateTime)
      throw ValidationException("Expected DateTime, got: $_value");
    return this;
  }

  /// Validates if the value is a valid DateTime string.
  ///
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "createdOn").isDateTimeString().asDateTime();
  /// ```
  JsonValidation isDateTimeString() {
    try {
      DateTime.parse(_value.toString());
    } on Exception {
      if (_altValue != null) {
        try {
          DateTime.parse(_altValue);
          _value = _altValue;
        } on Exception {
          throw ValidationException(
              "Invalid DateTime string for both value and altValue");
        }
      } else {
        throw ValidationException(
            "Invalid DateTime string and no alternative provided");
      }
    }
    return this;
  }

  /// Validates if the value is a valid DateTime string from an ObjectId.
  /// The ObjectId is a 24-character hexadecimal string that represents a unique identifier.
  /// The first 8 characters of the ObjectId represent the timestamp in seconds since the Unix epoch.
  /// This method extracts the first 8 characters of the ObjectId and converts it to a DateTime object.
  /// If the value is not a valid ObjectId, an exception is thrown.
  /// If an alternative value is provided, it is used instead of the value.
  /// If no alternative value is provided, an exception is thrown.
  /// Example:
  /// ```dart
  /// ValidateJson.inst(fragment: json, key: "objectId").isDateTimeFromObjectIdPartAsString().asDateTime();
  /// ```
  JsonValidation isDateTimeFromObjectIdPartAsString() {
    try {
      final timestampMillis =
          int.parse(_value.toString().substring(0, 8), radix: 16);

      DateTime.fromMillisecondsSinceEpoch(timestampMillis * 1000, isUtc: true);
      _value = DateTime.fromMillisecondsSinceEpoch(timestampMillis * 1000,
              isUtc: true)
          .toIso8601String();
    } on FormatException {
      if (_altValue != null) {
        try {
          DateTime.fromMillisecondsSinceEpoch(_altValue);
          _value = _altValue;
        } on FormatException {
          throw ValidationException(
              "Invalid DateTime string for both value and altValue");
        }
      } else {
        throw ValidationException(
            "Invalid DateTime string and no alternative provided");
      }
    } on Error {
      throw ValidationException("Invalid DateTime string from ObjectId");
    }
    return this;
  }

  DateTime get asDateTime => DateTime.parse(_value.toString());
}

class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);

  @override
  String toString() {
    return "ValidationException: $message";
  }
}

typedef JSON = Map<String, dynamic>;
typedef JSONList = List<JSON>;

// main() {
//   var res =
//       JsonValidation.inst(fragment: {"fld": "22"}, key: "fld").isString().value;
//   print(res);
//   res = JsonValidation.inst(fragment: {"fld": bool}, key: "fld").isBool().value;
//   print(res);
//
//   res = JsonValidation.inst(fragment: {
//     "fld": {"Will": 33}
//   }, key: "fld")
//       .isMap<String, int>()
//       .value;
//
//   print(res);
//
//   final newid = ObjectId().toHexString();
//   final badid = newid.substring(0, 7);
//   res = JsonValidation.inst(fragment: {"fld": badid}, key: "fld")
//       .isDateTimeFromObjectIdPartAsString()
//       .asDateTime;
//   print(res);
// }
