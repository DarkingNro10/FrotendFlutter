import '../models/cliente.dart';
import '../services/api_service.dart';

class ClienteRepository {
  final ApiService apiService;

  ClienteRepository(this.apiService);

  // Obtener todos los clientes
  Future<List<Cliente>> obtenerClientes() async {
    final data = await apiService.get('/cliente');
    return (data as List).map((json) => Cliente.fromJson(json)).toList();
  }

  // Agregar un nuevo cliente
  Future<void> agregarCliente(Cliente cliente) async {
    await apiService.post('/cliente', cliente.toJson());
  }

  // Actualizar un cliente existente
  Future<void> actualizarCliente(Cliente cliente) async {
    await apiService.put('/cliente', cliente.toJson());
  }

  // Eliminar un cliente
  Future<void> eliminarCliente(int id) async {
    await apiService.delete('/cliente/$id');
  }
}
