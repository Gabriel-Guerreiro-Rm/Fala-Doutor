import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';

// Nosso arquivo de banco de dados, agora o cérebro da operação.
import 'package:fala_doutor_api/database.dart';
// Precisamos do Drift para usar o MedicosCompanion.
import 'package:drift/drift.dart' show Value;


void main() async {
  // Conecta ao banco de dados e espera a conexão ficar pronta.
  final db = await connect();

  final app = Router();

  // Rota raiz, para testar se a API está no ar.
  app.get('/', (Request request) {
    return Response.ok(
      jsonEncode({'message': 'Bem-vindo à API Fala Doutor!'}),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // --- CRUD DE MÉDICOS ---

  // 1. READ (Ler todos os médicos)
  app.get('/medicos', (Request request) async {
    final todosMedicos = await (db.select(db.medicos)).get();
    final medicosJson = todosMedicos.map((medico) => medico.toJson()).toList();
    return Response.ok(
      jsonEncode(medicosJson),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // 2. CREATE (Criar um novo médico)
  app.post('/medicos', (Request request) async {
    final body = await request.readAsString();
    final dadosJson = jsonDecode(body) as Map<String, dynamic>;

    final companion = MedicosCompanion.insert(
      nome: dadosJson['nome'],
      cpf: dadosJson['cpf'],
      crm: dadosJson['crm'],
    );

    final novoMedico = await db.into(db.medicos).insertReturning(companion);
    return Response.ok(
      jsonEncode(novoMedico.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  });

  // 3. UPDATE (Atualizar um médico existente por ID)
  app.put('/medicos/<id>', (Request request, String id) async {
    final medicoId = int.parse(id);
    final body = await request.readAsString();
    final dadosJson = jsonDecode(body) as Map<String, dynamic>;

    final companion = MedicosCompanion(
      nome: Value(dadosJson['nome']),
      cpf: Value(dadosJson['cpf']),
      crm: Value(dadosJson['crm']),
    );

    final medicoAtualizado = await (db.update(db.medicos)..where((tbl) => tbl.id.equals(medicoId))).writeReturning(companion);
    
    if (medicoAtualizado.isNotEmpty) {
        return Response.ok(
            jsonEncode(medicoAtualizado.first.toJson()),
            headers: {'Content-Type': 'application/json'},
        );
    } else {
        return Response.notFound(
            jsonEncode({'error': 'Médico com id $id não encontrado'}),
            headers: {'Content-Type': 'application/json'},
        );
    }
  });

  // 4. DELETE (Excluir um médico por ID)
  app.delete('/medicos/<id>', (Request request, String id) async {
    final medicoId = int.parse(id);

    final rowsDeleted = await (db.delete(db.medicos)..where((tbl) => tbl.id.equals(medicoId))).go();

    if (rowsDeleted > 0) {
      return Response.ok(
        jsonEncode({'message': 'Médico com id $id foi removido com sucesso'}),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      return Response.notFound(
        jsonEncode({'error': 'Médico com id $id não encontrado'}),
        headers: {'Content-Type': 'application/json'},
      );
    }
  });


  const port = 8080;
  final server = await io.serve(app, 'localhost', port);
  print('Servidor rodando em http://localhost:${server.port}');
}