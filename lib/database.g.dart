// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MedicosTable extends Medicos with TableInfo<$MedicosTable, Medico> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cpfMeta = const VerificationMeta('cpf');
  @override
  late final GeneratedColumn<String> cpf = GeneratedColumn<String>(
    'cpf',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _crmMeta = const VerificationMeta('crm');
  @override
  late final GeneratedColumn<String> crm = GeneratedColumn<String>(
    'crm',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nome, cpf, crm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Medico> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('cpf')) {
      context.handle(
        _cpfMeta,
        cpf.isAcceptableOrUnknown(data['cpf']!, _cpfMeta),
      );
    } else if (isInserting) {
      context.missing(_cpfMeta);
    }
    if (data.containsKey('crm')) {
      context.handle(
        _crmMeta,
        crm.isAcceptableOrUnknown(data['crm']!, _crmMeta),
      );
    } else if (isInserting) {
      context.missing(_crmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Medico map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medico(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      cpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cpf'],
      )!,
      crm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}crm'],
      )!,
    );
  }

  @override
  $MedicosTable createAlias(String alias) {
    return $MedicosTable(attachedDatabase, alias);
  }
}

class Medico extends DataClass implements Insertable<Medico> {
  final int id;
  final String nome;
  final String cpf;
  final String crm;
  const Medico({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.crm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['cpf'] = Variable<String>(cpf);
    map['crm'] = Variable<String>(crm);
    return map;
  }

  MedicosCompanion toCompanion(bool nullToAbsent) {
    return MedicosCompanion(
      id: Value(id),
      nome: Value(nome),
      cpf: Value(cpf),
      crm: Value(crm),
    );
  }

  factory Medico.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medico(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      cpf: serializer.fromJson<String>(json['cpf']),
      crm: serializer.fromJson<String>(json['crm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'cpf': serializer.toJson<String>(cpf),
      'crm': serializer.toJson<String>(crm),
    };
  }

  Medico copyWith({int? id, String? nome, String? cpf, String? crm}) => Medico(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    cpf: cpf ?? this.cpf,
    crm: crm ?? this.crm,
  );
  Medico copyWithCompanion(MedicosCompanion data) {
    return Medico(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      cpf: data.cpf.present ? data.cpf.value : this.cpf,
      crm: data.crm.present ? data.crm.value : this.crm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medico(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cpf: $cpf, ')
          ..write('crm: $crm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, cpf, crm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medico &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.cpf == this.cpf &&
          other.crm == this.crm);
}

class MedicosCompanion extends UpdateCompanion<Medico> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> cpf;
  final Value<String> crm;
  const MedicosCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.cpf = const Value.absent(),
    this.crm = const Value.absent(),
  });
  MedicosCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String cpf,
    required String crm,
  }) : nome = Value(nome),
       cpf = Value(cpf),
       crm = Value(crm);
  static Insertable<Medico> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? cpf,
    Expression<String>? crm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (cpf != null) 'cpf': cpf,
      if (crm != null) 'crm': crm,
    });
  }

  MedicosCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? cpf,
    Value<String>? crm,
  }) {
    return MedicosCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      crm: crm ?? this.crm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
    if (crm.present) {
      map['crm'] = Variable<String>(crm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicosCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cpf: $cpf, ')
          ..write('crm: $crm')
          ..write(')'))
        .toString();
  }
}

class $PacientesTable extends Pacientes
    with TableInfo<$PacientesTable, Paciente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PacientesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cpfMeta = const VerificationMeta('cpf');
  @override
  late final GeneratedColumn<String> cpf = GeneratedColumn<String>(
    'cpf',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dataNascimentoMeta = const VerificationMeta(
    'dataNascimento',
  );
  @override
  late final GeneratedColumn<DateTime> dataNascimento =
      GeneratedColumn<DateTime>(
        'data_nascimento',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<PlanoSaude, String> plano =
      GeneratedColumn<String>(
        'plano',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PlanoSaude>($PacientesTable.$converterplano);
  @override
  List<GeneratedColumn> get $columns => [id, nome, cpf, dataNascimento, plano];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pacientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Paciente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('cpf')) {
      context.handle(
        _cpfMeta,
        cpf.isAcceptableOrUnknown(data['cpf']!, _cpfMeta),
      );
    } else if (isInserting) {
      context.missing(_cpfMeta);
    }
    if (data.containsKey('data_nascimento')) {
      context.handle(
        _dataNascimentoMeta,
        dataNascimento.isAcceptableOrUnknown(
          data['data_nascimento']!,
          _dataNascimentoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dataNascimentoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Paciente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Paciente(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      cpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cpf'],
      )!,
      dataNascimento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_nascimento'],
      )!,
      plano: $PacientesTable.$converterplano.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}plano'],
        )!,
      ),
    );
  }

  @override
  $PacientesTable createAlias(String alias) {
    return $PacientesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlanoSaude, String, String> $converterplano =
      const EnumNameConverter(PlanoSaude.values);
}

class Paciente extends DataClass implements Insertable<Paciente> {
  final int id;
  final String nome;
  final String cpf;
  final DateTime dataNascimento;
  final PlanoSaude plano;
  const Paciente({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.plano,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['cpf'] = Variable<String>(cpf);
    map['data_nascimento'] = Variable<DateTime>(dataNascimento);
    {
      map['plano'] = Variable<String>(
        $PacientesTable.$converterplano.toSql(plano),
      );
    }
    return map;
  }

  PacientesCompanion toCompanion(bool nullToAbsent) {
    return PacientesCompanion(
      id: Value(id),
      nome: Value(nome),
      cpf: Value(cpf),
      dataNascimento: Value(dataNascimento),
      plano: Value(plano),
    );
  }

  factory Paciente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Paciente(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      cpf: serializer.fromJson<String>(json['cpf']),
      dataNascimento: serializer.fromJson<DateTime>(json['dataNascimento']),
      plano: $PacientesTable.$converterplano.fromJson(
        serializer.fromJson<String>(json['plano']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'cpf': serializer.toJson<String>(cpf),
      'dataNascimento': serializer.toJson<DateTime>(dataNascimento),
      'plano': serializer.toJson<String>(
        $PacientesTable.$converterplano.toJson(plano),
      ),
    };
  }

  Paciente copyWith({
    int? id,
    String? nome,
    String? cpf,
    DateTime? dataNascimento,
    PlanoSaude? plano,
  }) => Paciente(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    cpf: cpf ?? this.cpf,
    dataNascimento: dataNascimento ?? this.dataNascimento,
    plano: plano ?? this.plano,
  );
  Paciente copyWithCompanion(PacientesCompanion data) {
    return Paciente(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      cpf: data.cpf.present ? data.cpf.value : this.cpf,
      dataNascimento: data.dataNascimento.present
          ? data.dataNascimento.value
          : this.dataNascimento,
      plano: data.plano.present ? data.plano.value : this.plano,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Paciente(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cpf: $cpf, ')
          ..write('dataNascimento: $dataNascimento, ')
          ..write('plano: $plano')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, cpf, dataNascimento, plano);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Paciente &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.cpf == this.cpf &&
          other.dataNascimento == this.dataNascimento &&
          other.plano == this.plano);
}

class PacientesCompanion extends UpdateCompanion<Paciente> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> cpf;
  final Value<DateTime> dataNascimento;
  final Value<PlanoSaude> plano;
  const PacientesCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.cpf = const Value.absent(),
    this.dataNascimento = const Value.absent(),
    this.plano = const Value.absent(),
  });
  PacientesCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String cpf,
    required DateTime dataNascimento,
    required PlanoSaude plano,
  }) : nome = Value(nome),
       cpf = Value(cpf),
       dataNascimento = Value(dataNascimento),
       plano = Value(plano);
  static Insertable<Paciente> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? cpf,
    Expression<DateTime>? dataNascimento,
    Expression<String>? plano,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (cpf != null) 'cpf': cpf,
      if (dataNascimento != null) 'data_nascimento': dataNascimento,
      if (plano != null) 'plano': plano,
    });
  }

  PacientesCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? cpf,
    Value<DateTime>? dataNascimento,
    Value<PlanoSaude>? plano,
  }) {
    return PacientesCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      plano: plano ?? this.plano,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
    if (dataNascimento.present) {
      map['data_nascimento'] = Variable<DateTime>(dataNascimento.value);
    }
    if (plano.present) {
      map['plano'] = Variable<String>(
        $PacientesTable.$converterplano.toSql(plano.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PacientesCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cpf: $cpf, ')
          ..write('dataNascimento: $dataNascimento, ')
          ..write('plano: $plano')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MedicosTable medicos = $MedicosTable(this);
  late final $PacientesTable pacientes = $PacientesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [medicos, pacientes];
}

typedef $$MedicosTableCreateCompanionBuilder =
    MedicosCompanion Function({
      Value<int> id,
      required String nome,
      required String cpf,
      required String crm,
    });
typedef $$MedicosTableUpdateCompanionBuilder =
    MedicosCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<String> cpf,
      Value<String> crm,
    });

class $$MedicosTableFilterComposer
    extends Composer<_$AppDatabase, $MedicosTable> {
  $$MedicosTableFilterComposer({
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

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get crm => $composableBuilder(
    column: $table.crm,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MedicosTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicosTable> {
  $$MedicosTableOrderingComposer({
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

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get crm => $composableBuilder(
    column: $table.crm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MedicosTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicosTable> {
  $$MedicosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get cpf =>
      $composableBuilder(column: $table.cpf, builder: (column) => column);

  GeneratedColumn<String> get crm =>
      $composableBuilder(column: $table.crm, builder: (column) => column);
}

class $$MedicosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicosTable,
          Medico,
          $$MedicosTableFilterComposer,
          $$MedicosTableOrderingComposer,
          $$MedicosTableAnnotationComposer,
          $$MedicosTableCreateCompanionBuilder,
          $$MedicosTableUpdateCompanionBuilder,
          (Medico, BaseReferences<_$AppDatabase, $MedicosTable, Medico>),
          Medico,
          PrefetchHooks Function()
        > {
  $$MedicosTableTableManager(_$AppDatabase db, $MedicosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> cpf = const Value.absent(),
                Value<String> crm = const Value.absent(),
              }) => MedicosCompanion(id: id, nome: nome, cpf: cpf, crm: crm),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required String cpf,
                required String crm,
              }) => MedicosCompanion.insert(
                id: id,
                nome: nome,
                cpf: cpf,
                crm: crm,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MedicosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicosTable,
      Medico,
      $$MedicosTableFilterComposer,
      $$MedicosTableOrderingComposer,
      $$MedicosTableAnnotationComposer,
      $$MedicosTableCreateCompanionBuilder,
      $$MedicosTableUpdateCompanionBuilder,
      (Medico, BaseReferences<_$AppDatabase, $MedicosTable, Medico>),
      Medico,
      PrefetchHooks Function()
    >;
typedef $$PacientesTableCreateCompanionBuilder =
    PacientesCompanion Function({
      Value<int> id,
      required String nome,
      required String cpf,
      required DateTime dataNascimento,
      required PlanoSaude plano,
    });
typedef $$PacientesTableUpdateCompanionBuilder =
    PacientesCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<String> cpf,
      Value<DateTime> dataNascimento,
      Value<PlanoSaude> plano,
    });

class $$PacientesTableFilterComposer
    extends Composer<_$AppDatabase, $PacientesTable> {
  $$PacientesTableFilterComposer({
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

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataNascimento => $composableBuilder(
    column: $table.dataNascimento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlanoSaude, PlanoSaude, String> get plano =>
      $composableBuilder(
        column: $table.plano,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$PacientesTableOrderingComposer
    extends Composer<_$AppDatabase, $PacientesTable> {
  $$PacientesTableOrderingComposer({
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

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataNascimento => $composableBuilder(
    column: $table.dataNascimento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plano => $composableBuilder(
    column: $table.plano,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PacientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PacientesTable> {
  $$PacientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get cpf =>
      $composableBuilder(column: $table.cpf, builder: (column) => column);

  GeneratedColumn<DateTime> get dataNascimento => $composableBuilder(
    column: $table.dataNascimento,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PlanoSaude, String> get plano =>
      $composableBuilder(column: $table.plano, builder: (column) => column);
}

class $$PacientesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PacientesTable,
          Paciente,
          $$PacientesTableFilterComposer,
          $$PacientesTableOrderingComposer,
          $$PacientesTableAnnotationComposer,
          $$PacientesTableCreateCompanionBuilder,
          $$PacientesTableUpdateCompanionBuilder,
          (Paciente, BaseReferences<_$AppDatabase, $PacientesTable, Paciente>),
          Paciente,
          PrefetchHooks Function()
        > {
  $$PacientesTableTableManager(_$AppDatabase db, $PacientesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PacientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PacientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PacientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> cpf = const Value.absent(),
                Value<DateTime> dataNascimento = const Value.absent(),
                Value<PlanoSaude> plano = const Value.absent(),
              }) => PacientesCompanion(
                id: id,
                nome: nome,
                cpf: cpf,
                dataNascimento: dataNascimento,
                plano: plano,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required String cpf,
                required DateTime dataNascimento,
                required PlanoSaude plano,
              }) => PacientesCompanion.insert(
                id: id,
                nome: nome,
                cpf: cpf,
                dataNascimento: dataNascimento,
                plano: plano,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PacientesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PacientesTable,
      Paciente,
      $$PacientesTableFilterComposer,
      $$PacientesTableOrderingComposer,
      $$PacientesTableAnnotationComposer,
      $$PacientesTableCreateCompanionBuilder,
      $$PacientesTableUpdateCompanionBuilder,
      (Paciente, BaseReferences<_$AppDatabase, $PacientesTable, Paciente>),
      Paciente,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MedicosTableTableManager get medicos =>
      $$MedicosTableTableManager(_db, _db.medicos);
  $$PacientesTableTableManager get pacientes =>
      $$PacientesTableTableManager(_db, _db.pacientes);
}
