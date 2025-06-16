
import '../typedefs/map_type.dart';
import 'validator_json_service.dart';

/// Contract enforcement for __Enums__ that stored in a mongodb collection.
/// should provide __clarity__ over how the value is represented in the collection and
/// how to access it. __Avoid__ storing the __index__, but __use__ instead the enum __name__.or string
/// representation of the class __ie "CoffeeType.decaf".__


/// Service class for validating a list of JSON records against a schema.
abstract class SchemaVerifierService {
  final ModelSchema schema;
  final TakeEvery takeEvery;
  final JSONList jsonList;
  final String idField;

  SchemaVerifierService({
    required this.schema,
    required this.takeEvery,
    required this.jsonList,
    this.idField = 'id',
  });

  /// Executes schema validation and returns a list of structured validation errors.
  List<VerificationError> call() {
    final errors = <VerificationError>[];
    for (final json in _dataSampling(jsonList)) {
      errors.addAll(_validateOne(json));
    }
    return errors;
  }

  JSONList _dataSampling(JSONList list) {
    switch (takeEvery) {
      case TakeEvery.first:
        return list.isNotEmpty ? [list.first] : [];
      case TakeEvery.tenth:
        return list
            .asMap()
            .entries
            .where((e) => e.key % 10 == 0)
            .map((e) => e.value)
            .toList()
            .cast();
      case TakeEvery.all:
      case TakeEvery.every:
      default:
        return list;
    }
  }

  List<VerificationError> _validateOne(JsonType json) {
    final messages = <VerificationError>[];
    for (var entry in schema
        .getDefs()
        .entries) {
      final key = entry.key;
      final def = entry.value;
      if (def is PrimitiveValidators) {
        messages.addAll(def.exec(json, key, idField));
      }
      // any nested-object logic should live in your VerifyServiceManager
    }
    return messages;
  }

}


enum TakeEvery {
  every,
  first,
  all,
  tenth,
}

abstract interface class ModelSchema {
  String get collectionName;
  Type getType(String fieldname);
  List<String> getFieldNames();
  List<String> getNullableFieldNames();
  List<String> getDateTimeStringFieldNames();
  Map<String, Object> getDefs();
}

abstract class PrimitiveValidators {
  List<VerificationError> exec(JsonType jsonMap, String fld, String identifier);

  factory PrimitiveValidators.datetime({required String collectionName}) =>
      DateTimeValidator(collectionName);
  factory PrimitiveValidators.string({required String collectionName}) =>
      StringValidator(collectionName);
  factory PrimitiveValidators.bool({required String collectionName}) =>
      BoolValidator(collectionName);
  factory PrimitiveValidators.int({required String collectionName}) =>
      IntValidator(collectionName);
  factory PrimitiveValidators.double({required String collectionName}) =>
      DoubleValidator(collectionName);
}


mixin class _ValidatorMixin {
  get collectionName => collectionName;

  List<VerificationError> _fieldExists(
      JsonType json, String fldname, String jsonIdentifier) {
    if (!json.containsKey(fldname)) {
      return [
        VerificationError(
          collection: collectionName,
          field: fldname,
          path: "_fieldExists()",
          message: "Field does not exist in JSON",
          actualValue: "n/a",
          identifier: json[jsonIdentifier]?.toString(),
        )
      ];
    }
    return [];
  }

  bool _isDateTimeString(dynamic value) {
    try {
      DateTime.parse(value);
    } catch (_) {
      return false;
    }
    return true;
  }
}

final class StringValidator with _ValidatorMixin implements PrimitiveValidators {
  StringValidator(this.collectionName);
  @override
  final String collectionName;

  @override
  List<VerificationError> exec(json, fldname, idKey) {
    final errors = _fieldExists(json, fldname, idKey);
    if (errors.isNotEmpty) return errors;
    if (json[fldname] is! String) {
      errors.add(VerificationError(
        collection: collectionName,
        field: fldname,
        path: fldname,
        actualValue: json[fldname],
        message: 'should be a String',
        identifier: json[idKey]?.toString(),
      ));
    }
    return errors;
  }
}

final class IntValidator with _ValidatorMixin implements PrimitiveValidators {
  IntValidator(this.collectionName);
  @override
  final String collectionName;

  @override
  List<VerificationError> exec(json, fldname, idKey) {
    final errors = _fieldExists(json, fldname, idKey);
    if (errors.isNotEmpty) return errors;
    if (json[fldname] is! int) {
      errors.add(VerificationError(
        collection: collectionName,
        field: fldname,
        path: fldname,
        actualValue: json[fldname],
        message: 'should be an int',
        identifier: json[idKey]?.toString(),
      ));
    }
    return errors;
  }
}

final class DoubleValidator with _ValidatorMixin implements PrimitiveValidators {
  DoubleValidator(this.collectionName);
  @override
  final String collectionName;

  @override
  List<VerificationError> exec(json, fldname, idKey) {
    final errors = _fieldExists(json, fldname, idKey);
    if (errors.isNotEmpty) return errors;
    final val = json[fldname];
    if (!(val is double || val is int)) {
      errors.add(VerificationError(
        collection: collectionName,
        field: fldname,
        path: fldname,
        actualValue: val,
        message: 'should be a double or int',
        identifier: json[idKey]?.toString(),
      ));
    }
    return errors;
  }
}

final class BoolValidator with _ValidatorMixin implements PrimitiveValidators {
  BoolValidator(this.collectionName);
  @override
  final String collectionName;

  @override
  List<VerificationError> exec(json, fldname, idKey) {
    final errors = _fieldExists(json, fldname, idKey);
    if (errors.isNotEmpty) return errors;
    if (json[fldname] is! bool) {
      errors.add(VerificationError(
        collection: collectionName,
        field: fldname,
        path: fldname,
        actualValue: json[fldname],
        message: 'should be a bool',
        identifier: json[idKey]?.toString(),
      ));
    }
    return errors;
  }
}

final class DateTimeValidator with _ValidatorMixin implements PrimitiveValidators {
  DateTimeValidator(this.collectionName);
  @override
  final String collectionName;

  @override
  List<VerificationError> exec(json, fldname, idKey) {
    final errors = _fieldExists(json, fldname, idKey);
    if (errors.isNotEmpty) return errors;
    final val = json[fldname];
    if (val is! String || !_isDateTimeString(val)) {
      errors.add(VerificationError(
        collection: collectionName,
        field: fldname,
        path: fldname,
        actualValue: val,
        message: 'not a valid DateTime string',
        identifier: json[idKey]?.toString(),
      ));
    }
    return errors;
  }
}

class VerificationError {
  final String collection;
  final String field;
  final String path;          // e.g., customer.contactDetails.email
  final String? identifier;   // value of id or objectId
  final String message;       // human-readable message
  final dynamic actualValue;  // what value failed
  final String? severity;     // optional: info | warning | error

  VerificationError({
    required this.collection,
    required this.field,
    required this.path,
    required this.message,
    this.identifier,
    this.actualValue,
    this.severity,
  });

  @override
  String toString() =>
      'Field: \'$field\' path: $path value: \"$actualValue\" — $message id:(${identifier ?? "?"})\n';
}

/// Utility class for grouping and filtering validation errors.
class VerifyErrorUtils {
  /// Groups validation errors by their schema collection name.
  static Map<String, List<VerificationError>> groupByCollection(List<VerificationError> errors) {
    final grouped = <String, List<VerificationError>>{};
    for (final error in errors) {
      grouped.putIfAbsent(error.collection, () => []).add(error);
    }
    return grouped;
  }

  /// Groups validation errors by their severity (e.g. 'error', 'warning').
  static Map<String, List<VerificationError>> groupBySeverity(List<VerificationError> errors) {
    final grouped = <String, List<VerificationError>>{};
    for (final error in errors) {
      final key = error.severity ?? 'error';
      grouped.putIfAbsent(key, () => []).add(error);
    }
    return grouped;
  }

  /// Filters validation errors to only include those of a specific severity level.
  static List<VerificationError> filterBySeverity(List<VerificationError> errors, String severity) =>
      errors.where((e) => e.severity == severity).toList();

  /// Filters validation errors to only include those from a specific collection.
  static List<VerificationError> filterByCollection(List<VerificationError> errors, String collection) =>
      errors.where((e) => e.collection == collection).toList();

  /// Returns a human-readable report of grouped validation errors.
  static String prettyPrintGroupedErrors(Map<String, List<VerificationError>> grouped) =>
      grouped.entries
          .map((e) => '[${e.key}]\n' + e.value.map((err) => '  - ${err.toString()}').join('\n'))
          .join('\n\n');
}
