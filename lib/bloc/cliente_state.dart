import '../models/cliente.dart';

abstract class ClienteState {}

class ClienteInitial extends ClienteState {}

class ClienteLoading extends ClienteState {}

class ClienteLoaded extends ClienteState {
  final List<Cliente> clientes;

  ClienteLoaded(this.clientes);
}

class ClienteError extends ClienteState {
  final String error;

  ClienteError(this.error);
}
