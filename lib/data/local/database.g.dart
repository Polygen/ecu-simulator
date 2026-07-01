// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $VehicleProfilesTable extends VehicleProfiles
    with TableInfo<$VehicleProfilesTable, VehicleProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vinMeta = const VerificationMeta('vin');
  @override
  late final GeneratedColumn<String> vin = GeneratedColumn<String>(
    'vin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
    'make',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _defaultRpmMeta = const VerificationMeta(
    'defaultRpm',
  );
  @override
  late final GeneratedColumn<int> defaultRpm = GeneratedColumn<int>(
    'default_rpm',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(800),
  );
  static const VerificationMeta _defaultSpeedMeta = const VerificationMeta(
    'defaultSpeed',
  );
  @override
  late final GeneratedColumn<int> defaultSpeed = GeneratedColumn<int>(
    'default_speed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    vin,
    make,
    model,
    year,
    odometer,
    defaultRpm,
    defaultSpeed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('vin')) {
      context.handle(
        _vinMeta,
        vin.isAcceptableOrUnknown(data['vin']!, _vinMeta),
      );
    } else if (isInserting) {
      context.missing(_vinMeta);
    }
    if (data.containsKey('make')) {
      context.handle(
        _makeMeta,
        make.isAcceptableOrUnknown(data['make']!, _makeMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    }
    if (data.containsKey('default_rpm')) {
      context.handle(
        _defaultRpmMeta,
        defaultRpm.isAcceptableOrUnknown(data['default_rpm']!, _defaultRpmMeta),
      );
    }
    if (data.containsKey('default_speed')) {
      context.handle(
        _defaultSpeedMeta,
        defaultSpeed.isAcceptableOrUnknown(
          data['default_speed']!,
          _defaultSpeedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      vin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vin'],
      )!,
      make: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      ),
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      )!,
      defaultRpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_rpm'],
      )!,
      defaultSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_speed'],
      )!,
    );
  }

  @override
  $VehicleProfilesTable createAlias(String alias) {
    return $VehicleProfilesTable(attachedDatabase, alias);
  }
}

class VehicleProfile extends DataClass implements Insertable<VehicleProfile> {
  final int id;
  final String name;
  final String vin;
  final String? make;
  final String? model;
  final int? year;
  final int odometer;
  final int defaultRpm;
  final int defaultSpeed;
  const VehicleProfile({
    required this.id,
    required this.name,
    required this.vin,
    this.make,
    this.model,
    this.year,
    required this.odometer,
    required this.defaultRpm,
    required this.defaultSpeed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['vin'] = Variable<String>(vin);
    if (!nullToAbsent || make != null) {
      map['make'] = Variable<String>(make);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    map['odometer'] = Variable<int>(odometer);
    map['default_rpm'] = Variable<int>(defaultRpm);
    map['default_speed'] = Variable<int>(defaultSpeed);
    return map;
  }

  VehicleProfilesCompanion toCompanion(bool nullToAbsent) {
    return VehicleProfilesCompanion(
      id: Value(id),
      name: Value(name),
      vin: Value(vin),
      make: make == null && nullToAbsent ? const Value.absent() : Value(make),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      odometer: Value(odometer),
      defaultRpm: Value(defaultRpm),
      defaultSpeed: Value(defaultSpeed),
    );
  }

  factory VehicleProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      vin: serializer.fromJson<String>(json['vin']),
      make: serializer.fromJson<String?>(json['make']),
      model: serializer.fromJson<String?>(json['model']),
      year: serializer.fromJson<int?>(json['year']),
      odometer: serializer.fromJson<int>(json['odometer']),
      defaultRpm: serializer.fromJson<int>(json['defaultRpm']),
      defaultSpeed: serializer.fromJson<int>(json['defaultSpeed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'vin': serializer.toJson<String>(vin),
      'make': serializer.toJson<String?>(make),
      'model': serializer.toJson<String?>(model),
      'year': serializer.toJson<int?>(year),
      'odometer': serializer.toJson<int>(odometer),
      'defaultRpm': serializer.toJson<int>(defaultRpm),
      'defaultSpeed': serializer.toJson<int>(defaultSpeed),
    };
  }

  VehicleProfile copyWith({
    int? id,
    String? name,
    String? vin,
    Value<String?> make = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<int?> year = const Value.absent(),
    int? odometer,
    int? defaultRpm,
    int? defaultSpeed,
  }) => VehicleProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    vin: vin ?? this.vin,
    make: make.present ? make.value : this.make,
    model: model.present ? model.value : this.model,
    year: year.present ? year.value : this.year,
    odometer: odometer ?? this.odometer,
    defaultRpm: defaultRpm ?? this.defaultRpm,
    defaultSpeed: defaultSpeed ?? this.defaultSpeed,
  );
  VehicleProfile copyWithCompanion(VehicleProfilesCompanion data) {
    return VehicleProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      vin: data.vin.present ? data.vin.value : this.vin,
      make: data.make.present ? data.make.value : this.make,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      defaultRpm: data.defaultRpm.present
          ? data.defaultRpm.value
          : this.defaultRpm,
      defaultSpeed: data.defaultSpeed.present
          ? data.defaultSpeed.value
          : this.defaultSpeed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vin: $vin, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('odometer: $odometer, ')
          ..write('defaultRpm: $defaultRpm, ')
          ..write('defaultSpeed: $defaultSpeed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    vin,
    make,
    model,
    year,
    odometer,
    defaultRpm,
    defaultSpeed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.vin == this.vin &&
          other.make == this.make &&
          other.model == this.model &&
          other.year == this.year &&
          other.odometer == this.odometer &&
          other.defaultRpm == this.defaultRpm &&
          other.defaultSpeed == this.defaultSpeed);
}

class VehicleProfilesCompanion extends UpdateCompanion<VehicleProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> vin;
  final Value<String?> make;
  final Value<String?> model;
  final Value<int?> year;
  final Value<int> odometer;
  final Value<int> defaultRpm;
  final Value<int> defaultSpeed;
  const VehicleProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.vin = const Value.absent(),
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.odometer = const Value.absent(),
    this.defaultRpm = const Value.absent(),
    this.defaultSpeed = const Value.absent(),
  });
  VehicleProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String vin,
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.odometer = const Value.absent(),
    this.defaultRpm = const Value.absent(),
    this.defaultSpeed = const Value.absent(),
  }) : name = Value(name),
       vin = Value(vin);
  static Insertable<VehicleProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? vin,
    Expression<String>? make,
    Expression<String>? model,
    Expression<int>? year,
    Expression<int>? odometer,
    Expression<int>? defaultRpm,
    Expression<int>? defaultSpeed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (vin != null) 'vin': vin,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (odometer != null) 'odometer': odometer,
      if (defaultRpm != null) 'default_rpm': defaultRpm,
      if (defaultSpeed != null) 'default_speed': defaultSpeed,
    });
  }

  VehicleProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? vin,
    Value<String?>? make,
    Value<String?>? model,
    Value<int?>? year,
    Value<int>? odometer,
    Value<int>? defaultRpm,
    Value<int>? defaultSpeed,
  }) {
    return VehicleProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      vin: vin ?? this.vin,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      odometer: odometer ?? this.odometer,
      defaultRpm: defaultRpm ?? this.defaultRpm,
      defaultSpeed: defaultSpeed ?? this.defaultSpeed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (vin.present) {
      map['vin'] = Variable<String>(vin.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (defaultRpm.present) {
      map['default_rpm'] = Variable<int>(defaultRpm.value);
    }
    if (defaultSpeed.present) {
      map['default_speed'] = Variable<int>(defaultSpeed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vin: $vin, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('odometer: $odometer, ')
          ..write('defaultRpm: $defaultRpm, ')
          ..write('defaultSpeed: $defaultSpeed')
          ..write(')'))
        .toString();
  }
}

class $DtcCodesTable extends DtcCodes with TableInfo<$DtcCodesTable, DtcCode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DtcCodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Stored'),
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicle_profiles (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    description,
    status,
    profileId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dtc_codes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DtcCode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DtcCode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DtcCode(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
    );
  }

  @override
  $DtcCodesTable createAlias(String alias) {
    return $DtcCodesTable(attachedDatabase, alias);
  }
}

class DtcCode extends DataClass implements Insertable<DtcCode> {
  final int id;
  final String code;
  final String? description;
  final String status;
  final int profileId;
  const DtcCode({
    required this.id,
    required this.code,
    this.description,
    required this.status,
    required this.profileId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['status'] = Variable<String>(status);
    map['profile_id'] = Variable<int>(profileId);
    return map;
  }

  DtcCodesCompanion toCompanion(bool nullToAbsent) {
    return DtcCodesCompanion(
      id: Value(id),
      code: Value(code),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      profileId: Value(profileId),
    );
  }

  factory DtcCode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DtcCode(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      profileId: serializer.fromJson<int>(json['profileId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(status),
      'profileId': serializer.toJson<int>(profileId),
    };
  }

  DtcCode copyWith({
    int? id,
    String? code,
    Value<String?> description = const Value.absent(),
    String? status,
    int? profileId,
  }) => DtcCode(
    id: id ?? this.id,
    code: code ?? this.code,
    description: description.present ? description.value : this.description,
    status: status ?? this.status,
    profileId: profileId ?? this.profileId,
  );
  DtcCode copyWithCompanion(DtcCodesCompanion data) {
    return DtcCode(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      description: data.description.present
          ? data.description.value
          : this.description,
      status: data.status.present ? data.status.value : this.status,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DtcCode(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('profileId: $profileId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, description, status, profileId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DtcCode &&
          other.id == this.id &&
          other.code == this.code &&
          other.description == this.description &&
          other.status == this.status &&
          other.profileId == this.profileId);
}

class DtcCodesCompanion extends UpdateCompanion<DtcCode> {
  final Value<int> id;
  final Value<String> code;
  final Value<String?> description;
  final Value<String> status;
  final Value<int> profileId;
  const DtcCodesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.profileId = const Value.absent(),
  });
  DtcCodesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    required int profileId,
  }) : code = Value(code),
       profileId = Value(profileId);
  static Insertable<DtcCode> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? description,
    Expression<String>? status,
    Expression<int>? profileId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (profileId != null) 'profile_id': profileId,
    });
  }

  DtcCodesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String?>? description,
    Value<String>? status,
    Value<int>? profileId,
  }) {
    return DtcCodesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      status: status ?? this.status,
      profileId: profileId ?? this.profileId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DtcCodesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('profileId: $profileId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VehicleProfilesTable vehicleProfiles = $VehicleProfilesTable(
    this,
  );
  late final $DtcCodesTable dtcCodes = $DtcCodesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    vehicleProfiles,
    dtcCodes,
  ];
}

typedef $$VehicleProfilesTableCreateCompanionBuilder =
    VehicleProfilesCompanion Function({
      Value<int> id,
      required String name,
      required String vin,
      Value<String?> make,
      Value<String?> model,
      Value<int?> year,
      Value<int> odometer,
      Value<int> defaultRpm,
      Value<int> defaultSpeed,
    });
typedef $$VehicleProfilesTableUpdateCompanionBuilder =
    VehicleProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> vin,
      Value<String?> make,
      Value<String?> model,
      Value<int?> year,
      Value<int> odometer,
      Value<int> defaultRpm,
      Value<int> defaultSpeed,
    });

final class $$VehicleProfilesTableReferences
    extends
        BaseReferences<_$AppDatabase, $VehicleProfilesTable, VehicleProfile> {
  $$VehicleProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$DtcCodesTable, List<DtcCode>> _dtcCodesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.dtcCodes,
    aliasName: $_aliasNameGenerator(
      db.vehicleProfiles.id,
      db.dtcCodes.profileId,
    ),
  );

  $$DtcCodesTableProcessedTableManager get dtcCodesRefs {
    final manager = $$DtcCodesTableTableManager(
      $_db,
      $_db.dtcCodes,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dtcCodesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehicleProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $VehicleProfilesTable> {
  $$VehicleProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultRpm => $composableBuilder(
    column: $table.defaultRpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultSpeed => $composableBuilder(
    column: $table.defaultSpeed,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dtcCodesRefs(
    Expression<bool> Function($$DtcCodesTableFilterComposer f) f,
  ) {
    final $$DtcCodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dtcCodes,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DtcCodesTableFilterComposer(
            $db: $db,
            $table: $db.dtcCodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehicleProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehicleProfilesTable> {
  $$VehicleProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultRpm => $composableBuilder(
    column: $table.defaultRpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultSpeed => $composableBuilder(
    column: $table.defaultSpeed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehicleProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehicleProfilesTable> {
  $$VehicleProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get vin =>
      $composableBuilder(column: $table.vin, builder: (column) => column);

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<int> get defaultRpm => $composableBuilder(
    column: $table.defaultRpm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultSpeed => $composableBuilder(
    column: $table.defaultSpeed,
    builder: (column) => column,
  );

  Expression<T> dtcCodesRefs<T extends Object>(
    Expression<T> Function($$DtcCodesTableAnnotationComposer a) f,
  ) {
    final $$DtcCodesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dtcCodes,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DtcCodesTableAnnotationComposer(
            $db: $db,
            $table: $db.dtcCodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehicleProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehicleProfilesTable,
          VehicleProfile,
          $$VehicleProfilesTableFilterComposer,
          $$VehicleProfilesTableOrderingComposer,
          $$VehicleProfilesTableAnnotationComposer,
          $$VehicleProfilesTableCreateCompanionBuilder,
          $$VehicleProfilesTableUpdateCompanionBuilder,
          (VehicleProfile, $$VehicleProfilesTableReferences),
          VehicleProfile,
          PrefetchHooks Function({bool dtcCodesRefs})
        > {
  $$VehicleProfilesTableTableManager(
    _$AppDatabase db,
    $VehicleProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehicleProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehicleProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> vin = const Value.absent(),
                Value<String?> make = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<int> defaultRpm = const Value.absent(),
                Value<int> defaultSpeed = const Value.absent(),
              }) => VehicleProfilesCompanion(
                id: id,
                name: name,
                vin: vin,
                make: make,
                model: model,
                year: year,
                odometer: odometer,
                defaultRpm: defaultRpm,
                defaultSpeed: defaultSpeed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String vin,
                Value<String?> make = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<int> defaultRpm = const Value.absent(),
                Value<int> defaultSpeed = const Value.absent(),
              }) => VehicleProfilesCompanion.insert(
                id: id,
                name: name,
                vin: vin,
                make: make,
                model: model,
                year: year,
                odometer: odometer,
                defaultRpm: defaultRpm,
                defaultSpeed: defaultSpeed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VehicleProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dtcCodesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dtcCodesRefs) db.dtcCodes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dtcCodesRefs)
                    await $_getPrefetchedData<
                      VehicleProfile,
                      $VehicleProfilesTable,
                      DtcCode
                    >(
                      currentTable: table,
                      referencedTable: $$VehicleProfilesTableReferences
                          ._dtcCodesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VehicleProfilesTableReferences(
                            db,
                            table,
                            p0,
                          ).dtcCodesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.profileId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VehicleProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehicleProfilesTable,
      VehicleProfile,
      $$VehicleProfilesTableFilterComposer,
      $$VehicleProfilesTableOrderingComposer,
      $$VehicleProfilesTableAnnotationComposer,
      $$VehicleProfilesTableCreateCompanionBuilder,
      $$VehicleProfilesTableUpdateCompanionBuilder,
      (VehicleProfile, $$VehicleProfilesTableReferences),
      VehicleProfile,
      PrefetchHooks Function({bool dtcCodesRefs})
    >;
typedef $$DtcCodesTableCreateCompanionBuilder =
    DtcCodesCompanion Function({
      Value<int> id,
      required String code,
      Value<String?> description,
      Value<String> status,
      required int profileId,
    });
typedef $$DtcCodesTableUpdateCompanionBuilder =
    DtcCodesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String?> description,
      Value<String> status,
      Value<int> profileId,
    });

final class $$DtcCodesTableReferences
    extends BaseReferences<_$AppDatabase, $DtcCodesTable, DtcCode> {
  $$DtcCodesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehicleProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.vehicleProfiles.createAlias(
        $_aliasNameGenerator(db.dtcCodes.profileId, db.vehicleProfiles.id),
      );

  $$VehicleProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$VehicleProfilesTableTableManager(
      $_db,
      $_db.vehicleProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DtcCodesTableFilterComposer
    extends Composer<_$AppDatabase, $DtcCodesTable> {
  $$DtcCodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$VehicleProfilesTableFilterComposer get profileId {
    final $$VehicleProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.vehicleProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleProfilesTableFilterComposer(
            $db: $db,
            $table: $db.vehicleProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DtcCodesTableOrderingComposer
    extends Composer<_$AppDatabase, $DtcCodesTable> {
  $$DtcCodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehicleProfilesTableOrderingComposer get profileId {
    final $$VehicleProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.vehicleProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicleProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DtcCodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DtcCodesTable> {
  $$DtcCodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$VehicleProfilesTableAnnotationComposer get profileId {
    final $$VehicleProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.vehicleProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicleProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DtcCodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DtcCodesTable,
          DtcCode,
          $$DtcCodesTableFilterComposer,
          $$DtcCodesTableOrderingComposer,
          $$DtcCodesTableAnnotationComposer,
          $$DtcCodesTableCreateCompanionBuilder,
          $$DtcCodesTableUpdateCompanionBuilder,
          (DtcCode, $$DtcCodesTableReferences),
          DtcCode,
          PrefetchHooks Function({bool profileId})
        > {
  $$DtcCodesTableTableManager(_$AppDatabase db, $DtcCodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DtcCodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DtcCodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DtcCodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> profileId = const Value.absent(),
              }) => DtcCodesCompanion(
                id: id,
                code: code,
                description: description,
                status: status,
                profileId: profileId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                Value<String?> description = const Value.absent(),
                Value<String> status = const Value.absent(),
                required int profileId,
              }) => DtcCodesCompanion.insert(
                id: id,
                code: code,
                description: description,
                status: status,
                profileId: profileId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DtcCodesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$DtcCodesTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$DtcCodesTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DtcCodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DtcCodesTable,
      DtcCode,
      $$DtcCodesTableFilterComposer,
      $$DtcCodesTableOrderingComposer,
      $$DtcCodesTableAnnotationComposer,
      $$DtcCodesTableCreateCompanionBuilder,
      $$DtcCodesTableUpdateCompanionBuilder,
      (DtcCode, $$DtcCodesTableReferences),
      DtcCode,
      PrefetchHooks Function({bool profileId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VehicleProfilesTableTableManager get vehicleProfiles =>
      $$VehicleProfilesTableTableManager(_db, _db.vehicleProfiles);
  $$DtcCodesTableTableManager get dtcCodes =>
      $$DtcCodesTableTableManager(_db, _db.dtcCodes);
}
