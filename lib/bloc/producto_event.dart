import '../models/producto.dart';

abstract class ProductoEvent {}

// Evento para obtener la lista de productos
class ObtenerProductos extends ProductoEvent {}

// Evento para agregar un nuevo producto
class AgregarProducto extends ProductoEvent {
  final Producto producto;

  AgregarProducto(this.producto);
}
// Evento para actualizar un producto
class ActualizarProducto extends ProductoEvent {
  final Producto producto;

  ActualizarProducto(this.producto);
}

// Evento para eliminar un producto
class EliminarProducto extends ProductoEvent {
  final int id;

  EliminarProducto(this.id);
}

