// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Budget extends $Budget with RealmEntity, RealmObjectBase, RealmObject {
  Budget(
    String period,
    double amount,
  ) {
    RealmObjectBase.set(this, 'period', period);
    RealmObjectBase.set(this, 'amount', amount);
  }

  Budget._();

  @override
  String get period => RealmObjectBase.get<String>(this, 'period') as String;
  @override
  set period(String value) => RealmObjectBase.set(this, 'period', value);

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  Stream<RealmObjectChanges<Budget>> get changes =>
      RealmObjectBase.getChanges<Budget>(this);

  @override
  Budget freeze() => RealmObjectBase.freezeObject<Budget>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Budget._);
    return  SchemaObject(ObjectType.realmObject, Budget, 'Budget', [
      const SchemaProperty('period', RealmPropertyType.string, primaryKey: true),
      const SchemaProperty('amount', RealmPropertyType.double),
    ]);
  }
}