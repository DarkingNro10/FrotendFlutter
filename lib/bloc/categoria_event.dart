import '../models/categoria.dart';

abstract class CategoriaEvent {}

// Obtener todas las categorías
class ObtenerCategorias extends CategoriaEvent {}

// Agregar una nueva categoría
class AgregarCategoria extends CategoriaEvent {
  final Categoria categoria;

  AgregarCategoria(this.categoria);
}

// Actualizar una categoría existente
class ActualizarCategoria extends CategoriaEvent {
  final int id;
  final Categoria categoria;

  ActualizarCategoria(this.id, this.categoria);
}

// Eliminar una categoría
class EliminarCategoria extends CategoriaEvent {
  final int id;

  EliminarCategoria(this.id);
}
