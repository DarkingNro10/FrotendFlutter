import '../models/carrito_item.dart';

abstract class CarritoEvent {}

// Obtener el carrito por usuario
class ObtenerCarrito extends CarritoEvent {
  final int userId;

  ObtenerCarrito(this.userId);
}

// Agregar un ítem al carrito
class AgregarAlCarrito extends CarritoEvent {
  final CarritoItem item;

  AgregarAlCarrito(this.item);
}

// Eliminar un ítem del carrito
class EliminarDelCarrito extends CarritoEvent {
  final int id;
  final int userId;

  EliminarDelCarrito(this.id, this.userId);
}

// Obtener el total del carrito
class ObtenerTotalCarrito extends CarritoEvent {
  final int userId;

  ObtenerTotalCarrito(this.userId);
}
