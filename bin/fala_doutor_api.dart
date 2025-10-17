import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';

final List<Map<String, dynamic>> _medicos = [
  {'id': '1', 'nome': 'Dr. Carlos Alberto', 'crm': '12345-SP', 'especialidade': 'Cardiologia'},
  {'id': '2', 'nome': 'Dra. Ana Maria', 'crm': '54321-RJ', 'especialidade': 'Pediatria'},
  {'id': '3', 'nome': 'Dr. João Kleber', 'crm': '98765-CE', 'especialidade': 'Ortopedia'},
];

void main() async {
  final app = Router();

  app.get('/', (Request request) {
    final responseMessage = {'message': 'Bem-vindo à API Fala Doutor!'};
    return Response.ok(
      jsonEncode(responseMessage),
      headers: {'Content-Type': 'application/json'},
    );
  });

  app.get('/medicos', (Request request) {
    return Response.ok(
      jsonEncode(_medicos),
      headers: {'Content-Type': 'application/json'},
    );
  });

  app.post('/medicos', (Request request) async {
    final body = await request.readAsString();
    final novoMedico = jsonDecode(body) as Map<String, dynamic>;
    
    novoMedico['id'] = (_medicos.length + 1).toString();
    _medicos.add(novoMedico);

    return Response.ok(
      jsonEncode(novoMedico),
      headers: {'Content-Type': 'application/json'},
    );
  });

  app.put('/medicos/<id>', (Request request, String id) async {
    final body = await request.readAsString();
    final dadosAtualizados = jsonDecode(body) as Map<String, dynamic>;

    final index = _medicos.indexWhere((medico) => medico['id'] == id);

    if (index != -1) {
      final medicoExistente = _medicos[index];
      medicoExistente['nome'] = dadosAtualizados['nome'];
      medicoExistente['crm'] = dadosAtualizados['crm'];
      medicoExistente['especialidade'] = dadosAtualizados['especialidade'];
      
      return Response.ok(
        jsonEncode(medicoExistente),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      return Response.notFound(
        jsonEncode({'error': 'Médico com id $id não encontrado'}),
        headers: {'Content-Type': 'application/json'},
      );
    }
  });

  app.delete('/medicos/<id>', (Request request, String id) {
    _medicos.removeWhere((medico) => medico['id'] == id);
    return Response.ok(
      jsonEncode({'message': 'Médico com id $id foi removido com sucesso'}),
      headers: {'Content-Type': 'application/json'},
    );
  });

  const port = 8080;
  final server = await io.serve(app, 'localhost', port);
  print('Servidor rodando em http://localhost:${server.port}');
}