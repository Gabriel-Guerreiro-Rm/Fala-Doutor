import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';
import 'package:fala_doutor_api/database.dart';
import 'package:drift/drift.dart' show Value;

DateTime parseData(String data) {
  final partes = data.split('-');
  final dia = int.parse(partes[0]);
  final mes = int.parse(partes[1]);
  final ano = int.parse(partes[2]);
  return DateTime(ano, mes, dia);
}

String formatData(DateTime data) {
  return '${data.day.toString().padLeft(2, '0')}-'
      '${data.month.toString().padLeft(2, '0')}-'
      '${data.year}';
}

bool planoValido(String? plano) {
  if (plano == null) return false;
  return ['plano1', 'plano2', 'plano3'].contains(plano);
}

bool validarCpf(String cpf) {
  final cpfRegex = RegExp(r'^\d{11}$');
  return cpfRegex.hasMatch(cpf);
}

bool validarCrm(String crm) {
  final crmRegex = RegExp(r'^\d{5}/[A-Z]{2}$');
  return crmRegex.hasMatch(crm);
}

Map<String, dynamic> pacienteToJson(Paciente p) {
  return {
    'id': p.id,
    'nome': p.nome,
    'cpf': p.cpf,
    'data_nascimento': formatData(p.dataNascimento),
    'plano': p.plano.name,
  };
}

void main() async {
  final db = await connect();
  final app = Router();

  app.get('/', (Request request) {
    return Response.ok(jsonEncode({'message': 'Bem-vindo à API Fala Doutor!'}),
        headers: {'Content-Type': 'application/json'});
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
    final nome = dados['nome'];
    final cpf = dados['cpf'];
    final crm = dados['crm'];
    final erros = <String>[];

    if (!validarCpf(cpf)) {
      erros.add('CPF inválido. Deve conter exatamente 11 dígitos numéricos.');
    }

    if (!validarCrm(crm)) {
      erros.add('CRM inválido. Deve ter 5 números seguido da sigla do estado (ex: 12345/CE).');
    }

    final medicoCpfExiste = await (db.select(db.medicos)
          ..where((tbl) => tbl.cpf.equals(cpf)))
        .getSingleOrNull();
    final medicoCrmExiste = await (db.select(db.medicos)
          ..where((tbl) => tbl.crm.equals(crm)))
        .getSingleOrNull();

    if (medicoCpfExiste != null) {
      erros.add('Já existe um médico com este CPF cadastrado');
    }
    if (medicoCrmExiste != null) {
      erros.add('Já existe um médico com este CRM cadastrado');
    }

    if (erros.isNotEmpty) {
      return Response.badRequest(
        body: jsonEncode({'error': erros}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final novo = MedicosCompanion.insert(nome: nome, cpf: cpf, crm: crm);
    final medico = await db.into(db.medicos).insertReturning(novo);
    return Response.ok(jsonEncode(medico.toJson()),
        headers: {'Content-Type': 'application/json'});
  });

  app.put('/medicos/<id>', (Request request, String id) async {
    final medicoId = int.parse(id);
    final body = await request.readAsString();
    final dados = jsonDecode(body);

    final cpf = dados['cpf'];
    final crm = dados['crm'];

    if (cpf != null && !validarCpf(cpf)) {
      return Response.badRequest(
          body: jsonEncode({'error': 'CPF inválido. Deve conter exatamente 11 dígitos numéricos.'}),
          headers: {'Content-Type': 'application/json'});
    }

    if (crm != null && !validarCrm(crm)) {
      return Response.badRequest(
          body: jsonEncode({'error': 'CRM inválido. Deve ter 5 números seguido da sigla do estado (ex: 12345/CE).'}),
          headers: {'Content-Type': 'application/json'});
    }

    final update = MedicosCompanion(
      nome: Value(dados['nome']),
      cpf: Value(cpf),
      crm: Value(crm),
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

  app.get('/pacientes', (Request request) async {
    final pacientes = await db.select(db.pacientes).get();
    final pacientesJson = pacientes.map(pacienteToJson).toList();
    return Response.ok(jsonEncode(pacientesJson),
        headers: {'Content-Type': 'application/json'});
  });

  app.post('/pacientes', (Request request) async {
    final body = await request.readAsString();
    final dados = jsonDecode(body);
    final plano = dados['plano']?.toString().toLowerCase();

    if (!planoValido(plano)) {
      return Response.badRequest(
          body: jsonEncode({'error': 'Plano inválido. Use apenas: plano1, plano2 ou plano3'}),
          headers: {'Content-Type': 'application/json'});
    }

    final cpf = dados['cpf'];

    if (!validarCpf(cpf)) {
      return Response.badRequest(
          body: jsonEncode({'error': 'CPF inválido. Deve conter exatamente 11 dígitos numéricos.'}),
          headers: {'Content-Type': 'application/json'});
    }

    final pacienteExiste = await (db.select(db.pacientes)
          ..where((tbl) => tbl.cpf.equals(cpf)))
        .getSingleOrNull();
    if (pacienteExiste != null) {
      return Response.badRequest(
          body: jsonEncode({'error': 'Já existe um paciente com este CPF cadastrado'}),
          headers: {'Content-Type': 'application/json'});
    }

    final novo = PacientesCompanion.insert(
      nome: dados['nome'],
      cpf: cpf,
      dataNascimento: parseData(dados['data_nascimento']),
      plano: PlanoSaude.values.firstWhere((p) => p.name.toLowerCase() == plano),
    );
    final paciente = await db.into(db.pacientes).insertReturning(novo);
    return Response.ok(jsonEncode(pacienteToJson(paciente)),
        headers: {'Content-Type': 'application/json'});
  });

  app.put('/pacientes/<id>', (Request request, String id) async {
    final pacienteId = int.parse(id);
    final body = await request.readAsString();
    final dados = jsonDecode(body);
    final plano = dados['plano']?.toString().toLowerCase();

    if (plano != null && !planoValido(plano)) {
      return Response.badRequest(
          body: jsonEncode({'error': 'Plano inválido. Use apenas: plano1, plano2 ou plano3'}),
          headers: {'Content-Type': 'application/json'});
    }

    final cpf = dados['cpf'];
    if (cpf != null && !validarCpf(cpf)) {
      return Response.badRequest(
          body: jsonEncode({'error': 'CPF inválido. Deve conter exatamente 11 dígitos numéricos.'}),
          headers: {'Content-Type': 'application/json'});
    }

    final update = PacientesCompanion(
      nome: Value(dados['nome']),
      cpf: Value(cpf),
      dataNascimento: Value(parseData(dados['data_nascimento'])),
      plano: plano != null
          ? Value(PlanoSaude.values.firstWhere((p) => p.name.toLowerCase() == plano))
          : const Value.absent(),
    );
    final result = await (db.update(db.pacientes)
          ..where((tbl) => tbl.id.equals(pacienteId)))
        .writeReturning(update);
    if (result.isNotEmpty) {
      return Response.ok(jsonEncode(pacienteToJson(result.first)),
          headers: {'Content-Type': 'application/json'});
    } else {
      return Response.notFound(
          jsonEncode({'error': 'Paciente não encontrado'}),
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
      return Response.notFound(
          jsonEncode({'error': 'Paciente não encontrado'}),
          headers: {'Content-Type': 'application/json'});
    }
  });

  const port = 8080;
  final server = await io.serve(app, 'localhost', port);
  print('Servidor rodando em http://localhost:${server.port}');
}