import '../models/categoria.dart';
import '../services/api_service.dart';

class CategoriaRepository {
  final ApiService apiService;

  CategoriaRepository(this.apiService);

  // Obtener todas las categorías
  Future<List<Categoria>> obtenerCategorias() async {
    final data = await apiService.get('/categoria');
    return (data as List).map((json) => Categoria.fromJson(json)).toList();
  }

  // Agregar una nueva categoría
  Future<void> agregarCategoria(Categoria categoria) async {
    await apiService.post('/categoria', categoria.toJson());
  }

  // Actualizar una categoría existente
  Future<void> actualizarCategoria(int id, Categoria categoria) async {
    await apiService.put('/categoria/$id', categoria.toJson());
  }

  // Eliminar una categoría
  Future<void> eliminarCategoria(int id) async {
    await apiService.delete('/categoria/$id');
  }
}
