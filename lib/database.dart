import 'package.drift/drift.dart';
import 'package:drift/postgres.dart';
import 'package:postgres/postgres.dart' as pg;

part 'database.g.dart';

class Medicos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  TextColumn get cpf => text().unique()();
  TextColumn get crm => text().unique()();
}

enum PlanoSaude { plano1, plano2, plano3 }

class Pacientes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  TextColumn get cpf => text().unique()();
  DateTimeColumn get dataNascimento => dateTime()();
  TextColumn get plano => text().map(const EnumNameConverter(PlanoSaude.values))();
}

@DriftDatabase(tables: [Medicos, Pacientes])

class AppDatabase extends _$AppDatabase {

  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}

AppDatabase connect() {
  final connection = pg.Endpoint(
    host: 'localhost',
    port: 5433,
    database: 'fala_doutor',
    username: 'postgres',
    password: '12345678',
  );

  final db = AppDatabase(
    PostgresDatabase.v2(endpoint: connection)
  );

  return db;
}