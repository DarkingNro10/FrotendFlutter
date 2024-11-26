import '../models/cliente.dart';

abstract class ClienteEvent {}

// Obtener todos los clientes
class ObtenerClientes extends ClienteEvent {}

// Agregar un nuevo cliente
class AgregarCliente extends ClienteEvent {
  final Cliente cliente;

  AgregarCliente(this.cliente);
}

// Actualizar un cliente existente
class ActualizarCliente extends ClienteEvent {
  final Cliente cliente;

  ActualizarCliente(this.cliente);
}

// Eliminar un cliente
class EliminarCliente extends ClienteEvent {
  final int id;

  EliminarCliente(this.id);
}
