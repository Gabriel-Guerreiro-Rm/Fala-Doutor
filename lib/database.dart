import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
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
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}

Future<AppDatabase> connect() async {
  final executor = PgDatabase(
    endpoint: pg.Endpoint(
      host: 'localhost',
      database: 'fala_doutor',
      username: 'postgres',
      password: '123456789',
    ),
    settings: pg.ConnectionSettings(
      sslMode: pg.SslMode.disable,
    ),
    logStatements: true,
  );
  return AppDatabase(executor);
}