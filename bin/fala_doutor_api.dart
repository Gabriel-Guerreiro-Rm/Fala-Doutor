import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';
import 'package:fala_doutor_api/database.dart';
import 'package:drift/drift.dart' show Value;

void main() async {
  final db = await connect();
  final app = Router();

  app.get('/', (Request request) {
    return Response.ok(
      jsonEncode({'message': 'Bem-vindo à API Fala Doutor!'}),
      headers: {'Content-Type': 'application/json'},
    );
  });

  app.get('/medicos', (Request request) async {
    final medicos = await db.select(db.medicos).get();
    final medicosJson = medicos.map((m) => m.toJson()).toList();
    return Response.ok(jsonEncode(medicosJson),
        headers: {'Content-Type': 'application/json'});
  });

  app.post('/medicos', (Request request) async {
    final body = await request.readAsString();
    final dados = jsonDecode(body);

    final novo = MedicosCompanion.insert(
      nome: dados['nome'],
      cpf: dados['cpf'],
      crm: dados['crm'],
    );

    final medico = await db.into(db.medicos).insertReturning(novo);
    return Response.ok(jsonEncode(medico.toJson()),
        headers: {'Content-Type': 'application/json'});
  });

  app.put('/medicos/<id>', (Request request, String id) async {
    final medicoId = int.parse(id);
    final body = await request.readAsString();
    final dados = jsonDecode(body);

    final update = MedicosCompanion(
      nome: Value(dados['nome']),
      cpf: Value(dados['cpf']),
      crm: Value(dados['crm']),
    );

    final result = await (db.update(db.medicos)
          ..where((tbl) => tbl.id.equals(medicoId)))
        .writeReturning(update);

    if (result.isNotEmpty) {
      return Response.ok(jsonEncode(result.first.toJson()),
          headers: {'Content-Type': 'application/json'});
    } else {
      return Response.notFound(jsonEncode({'error': 'Médico não encontrado'}),
          headers: {'Content-Type': 'application/json'});
    }
  });

  app.delete('/medicos/<id>', (Request request, String id) async {
    final medicoId = int.parse(id);
    final deleted = await (db.delete(db.medicos)
          ..where((tbl) => tbl.id.equals(medicoId)))
        .go();

    if (deleted > 0) {
      return Response.ok(
          jsonEncode({'message': 'Médico com id $id removido com sucesso'}),
          headers: {'Content-Type': 'application/json'});
    } else {
      return Response.notFound(jsonEncode({'error': 'Médico não encontrado'}),
          headers: {'Content-Type': 'application/json'});
    }
  });

  bool planoValido(String? plano) {
    if (plano == null) return false;
    return ['plano1', 'plano2', 'plano3'].contains(plano);
  }

  app.get('/pacientes', (Request request) async {
    final pacientes = await db.select(db.pacientes).get();
    final pacientesJson = pacientes.map((p) => p.toJson()).toList();
    return Response.ok(jsonEncode(pacientesJson),
        headers: {'Content-Type': 'application/json'});
  });

  app.post('/pacientes', (Request request) async {
    final body = await request.readAsString();
    final dados = jsonDecode(body);

    final plano = dados['plano']?.toString().toLowerCase();
    if (!planoValido(plano)) {
      return Response.badRequest(
        body: jsonEncode(
            {'error': 'Plano inválido. Use apenas: plano1, plano2 ou plano3'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final novo = PacientesCompanion.insert(
      nome: dados['nome'],
      cpf: dados['cpf'],
      dataNascimento: DateTime.parse(dados['data_nascimento']),
      plano: PlanoSaude.values
          .firstWhere((p) => p.name.toLowerCase() == plano), // conversão segura
    );

    final paciente = await db.into(db.pacientes).insertReturning(novo);
    return Response.ok(jsonEncode(paciente.toJson()),
        headers: {'Content-Type': 'application/json'});
  });

  app.put('/pacientes/<id>', (Request request, String id) async {
    final pacienteId = int.parse(id);
    final body = await request.readAsString();
    final dados = jsonDecode(body);

    final plano = dados['plano']?.toString().toLowerCase();
    if (plano != null && !planoValido(plano)) {
      return Response.badRequest(
        body: jsonEncode(
            {'error': 'Plano inválido. Use apenas: plano1, plano2 ou plano3'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final update = PacientesCompanion(
      nome: Value(dados['nome']),
      cpf: Value(dados['cpf']),
      dataNascimento: Value(DateTime.parse(dados['data_nascimento'])),
      plano: plano != null
          ? Value(PlanoSaude.values
              .firstWhere((p) => p.name.toLowerCase() == plano))
          : const Value.absent(),
    );

    final result = await (db.update(db.pacientes)
          ..where((tbl) => tbl.id.equals(pacienteId)))
        .writeReturning(update);

    if (result.isNotEmpty) {
      return Response.ok(jsonEncode(result.first.toJson()),
          headers: {'Content-Type': 'application/json'});
    } else {
      return Response.notFound(jsonEncode({'error': 'Paciente não encontrado'}),
          headers: {'Content-Type': 'application/json'});
    }
  });

  app.delete('/pacientes/<id>', (Request request, String id) async {
    final pacienteId = int.parse(id);
    final deleted = await (db.delete(db.pacientes)
          ..where((tbl) => tbl.id.equals(pacienteId)))
        .go();

    if (deleted > 0) {
      return Response.ok(
          jsonEncode({'message': 'Paciente com id $id removido com sucesso'}),
          headers: {'Content-Type': 'application/json'});
    } else {
      return Response.notFound(jsonEncode({'error': 'Paciente não encontrado'}),
          headers: {'Content-Type': 'application/json'});
    }
  });

  const port = 8080;
  final server = await io.serve(app, 'localhost', port);
  print('Servidor rodando em http://localhost:${server.port}');
}