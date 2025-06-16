
import 'package:dddv1/src/core/json_verification/schema_verification.core.dart';

import '../typedefs/map_type.dart';

class ModelSchemaImpl implements ModelSchema {
  final String _collectionName;

  /// object is a PrimitiveValidator,customValidaotr, enumValidatore, or nestedSchema, nestedSchemaCollection
  final Map<String, Object> _defs = {};

  ModelSchemaImpl({required collectionName}) : _collectionName = collectionName;

  @override
  String get collectionName => _collectionName;

  @override
  List<String> getDateTimeStringFieldNames() => [];

  @override
  Map<String, Object> getDefs() => _defs;

  addField(String fieldname, PrimitiveValidators validator) {
    getDefs().putIfAbsent(fieldname, () => validator);
    return this;
  }

  ////// `fieldName`: The JSON key that corresponds to the entity field name of the collection.
  /// `collectionName`: The name of the collection associated with the nested schema.
  NestedSchema addNestedSchema({
    /// json key equating or entity fieldname.
    required jsonKey,
    required collectionName,
  }) {
    final NestedSchema nested = NestedSchema(
      fieldName: jsonKey,
      collectionName: collectionName,
    );
    getDefs().putIfAbsent(jsonKey, () => nested);
    return nested;
  }

  NestedListSchema addNestedListSchema({
    /// json key equating or entity fieldname.
    required jsonKey,
    required collectionName,
  }) {
    final NestedListSchema list = NestedListSchema(
      fieldName: jsonKey,
      collectionName: collectionName,
    );
    getDefs().putIfAbsent(jsonKey, () => list);
    return list;
  }

  @override
  List<String> getFieldNames() => _defs.keys.toList();

  @override
  List<String> getNullableFieldNames() => [];

  @override
  Type getType(String fieldname) =>
      throw UnimplementedError("Method not implemented");
}

/// New schema type to validate a List of Maps against a NestedSchema
class NestedListSchema {
  final String fieldName;
  final String idField;
  final NestedSchema itemSchema;

  NestedListSchema({
    required this.fieldName,
    collectionName,
    this.idField = 'id',
  }) : itemSchema = NestedSchema(
         fieldName: fieldName,
         collectionName: collectionName,
       );

  List<VerificationError> execute(dynamic listValue) {
    final messages = <VerificationError>[];
    if (listValue is List) {
      for (var i = 0; i < listValue.length; i++) {
        final element = listValue[i];
        if (element is Map<String, dynamic>) {
          final nestedErrors = (itemSchema).executeVerification(element);
          for (var err in nestedErrors) {
            messages.add(
              VerificationError(
                collection: err.collection,
                field: err.field,
                path: '$fieldName[$i].${err.path}',
                actualValue: err.actualValue,
                message: err.message,
                identifier: err.identifier,
                severity: err.severity,
              ),
            );
          }
        } else {
          messages.add(
            VerificationError(
              collection: itemSchema.collectionName,
              field: fieldName,
              path: '$fieldName[$i]',
              actualValue: element,
              message: 'expected object in list',
              identifier:
                  element is Map<String, dynamic>
                      ? element[idField]?.toString()
                      : null,
            ),
          );
        }
      }
    } else {
      messages.add(
        VerificationError(
          collection: itemSchema.collectionName,
          field: fieldName,
          path: fieldName,
          actualValue: listValue,
          message: 'expected a list of objects',
          identifier: null,
        ),
      );
    }
    return messages;
  }

  addField(String fieldname, PrimitiveValidators validator) {
    itemSchema.addField(fieldname, validator);
    return this;
  }
}

class NestedSchema extends ModelSchemaImpl {
  ///the keyvalue reference to json values to be validated.
  final String fieldName;

  NestedSchema({required super.collectionName, required this.fieldName});

  List<VerificationError> executeVerification(JsonType json) {
    final messages = <VerificationError>[];
    for (var entry in getDefs().entries) {
      final key = entry.key;
      final def = entry.value;

      if (def is PrimitiveValidators) {
        final msg = def.exec(json, key, "id");
        print(msg);
        messages.addAll(msg);
      } else if (def is NestedSchema) {
        final nestedJson = json[key];
        if (nestedJson is Map<String, dynamic>) {
          // Recursively collect nested errors
          final msg = def.executeVerification(nestedJson);
          print(msg);
          messages.addAll(msg);
        }
        if (def is NestedListSchema) {
          if (json[key] is List) {
            final msg = def.executeVerification(json[key]);
            print(msg);
            messages.addAll(msg);
          }
        } else {
          // Type mismatch on the nested field
          messages.add(
            VerificationError(
              collection: collectionName,
              field: key,
              path: '$fieldName.$key',
              actualValue: nestedJson,
              message: 'expected nested object',
              identifier: json["id"]?.toString(),
            ),
          );
        }
      }
    }
    print('accumulating errors in nested schema ${messages}');
    return messages;
  }
}

class VerifyServiceManager {
  final TakeEvery takeEvery;

  VerifyServiceManager({required this.takeEvery, collectionName}) {
    _rootSchema = createSchema(collectionName: collectionName);
  }

  late JsonList jsonList;
  late ModelSchemaImpl _rootSchema;

  ModelSchemaImpl get rootSchema => _rootSchema;

  ModelSchemaImpl createSchema({collectionName}) {
    _rootSchema = ModelSchemaImpl(collectionName: collectionName);
    return _rootSchema;
  }

  execute(JsonList list) {
    final List<VerificationError> errors = [];
    final sampled = _dataSampling(list);
    for (final json in sampled) {
      errors.addAll(executeVerification(json));
    }
    return errors;
  }

  List<VerificationError> executeVerification(JsonType json) {
    final List<VerificationError> messages = [];

    for (var entry in rootSchema.getDefs().entries) {
      final field = entry.key;

      if (entry.value is PrimitiveValidators) {
        final primitives = [bool, int, double, String, DateTime];

        if (!json.containsKey(field)) {
          assert(
            json.containsKey(field) &&
                primitives.contains(json[field].runtimeType),
            "incorrect verifyman config for field $field of type ${json[field].runtimeType}",
          );
        }

        final validator = entry.value as PrimitiveValidators;
        messages.addAll(validator.exec(json, field, "id"));
      } else if (entry.value is NestedSchema) {
        if (!json.containsKey(field))
          assert(
            json[field].runtimeType is Map<String, dynamic>,
            "incorrect verifyServiceManager config for field $field, expected a Map<> but got  type ${json[field].runtimeType}",
          );

        final nestedSchema = entry.value as NestedSchema;
        messages.addAll(nestedSchema.executeVerification(json[entry.key]));
      } else if (entry.value is NestedListSchema) {
        if (!json.containsKey(field))
          assert(
            json[field].runtimeType is List<Map<String, dynamic>>,
            "incorrect verifyServiceManager config for field $field, expected a Map<> but got  type ${json[field].runtimeType}",
          );

        // validate each element of the list
        messages.addAll(
          (entry.value as NestedListSchema).execute(json[entry.key]),
        );
      }
    }

    return messages;
  }

  JsonList _dataSampling(JsonList list) {
    switch (takeEvery) {
      case TakeEvery.first:
        return list.isNotEmpty ? [list.first] : [];
      case TakeEvery.tenth:
        return [for (var i = 0; i < list.length; i += 10) list[i]];
      case TakeEvery.all:
      case TakeEvery.every:
      default:
        return list;
    }
  }
}

///
///
///
main() {
  JsonList json = [
    {
      "age": 12,
      "name": "Bob",
      "address": {"street": "123 Main St", "city": "Anytown"},
      "cartitems": [
        {"name": "item1", "price": "10.99"},
        {"name": "item2", "price": 20.99},
        {"name": "item3", "price": 30.99},
      ],
    },
  ];

  VerifyServiceManager mgr = VerifyServiceManager(
    takeEvery: TakeEvery.every,
    collectionName: 'arty',
  );
  mgr.rootSchema
      .addField("name", PrimitiveValidators.string(collectionName: "Arty"))
      .addField("age", PrimitiveValidators.int(collectionName: "Arty"))
      .addNestedSchema(jsonKey: 'address', collectionName: 'Address')
      .addField(
        "street1",
        PrimitiveValidators.string(collectionName: "Address"),
      )
      .addField("city", PrimitiveValidators.string(collectionName: "Address"))
      .addNestedListSchema(jsonKey: 'cartitems', collectionName: 'CartItems')
      .addField(
        "name",
        PrimitiveValidators.string(collectionName: "CartItems"),
      )
      .addField(
        "priceX",
        PrimitiveValidators.double(collectionName: "CartItems"),
      );

  print(mgr.rootSchema.getFieldNames());
  final errors = mgr.execute(json);
}
