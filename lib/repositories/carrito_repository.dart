import '../models/carrito_item.dart';
import '../services/api_service.dart';

class CarritoRepository {
  final ApiService apiService;

  CarritoRepository(this.apiService);

  // Obtener todos los ítems del carrito por usuario
  Future<List<CarritoItem>> obtenerCarrito(int userId) async {
    final data = await apiService.get('/carrito/$userId');
    return (data as List).map((item) => CarritoItem.fromJson(item)).toList();
  }

  // Agregar un ítem al carrito
  Future<void> agregarAlCarrito(CarritoItem item) async {
    await apiService.post('/carrito/add', item.toJson());
  }

  // Eliminar un ítem del carrito
  Future<void> eliminarDelCarrito(int id) async {
    await apiService.delete('/carrito/remove/$id');
  }

  // Obtener el precio total del carrito
  Future<double> obtenerTotalCarrito(int userId) async {
    final data = await apiService.get('/carrito/total/$userId');
    return (data as num).toDouble(); // Convierte el total a un double
  }
}
