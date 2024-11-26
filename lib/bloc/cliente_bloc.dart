import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cliente.dart';
import '../repositories/cliente_repository.dart';
import 'cliente_event.dart';
import 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  final ClienteRepository clienteRepository;

  ClienteBloc(this.clienteRepository) : super(ClienteInitial()) {
    on<ObtenerClientes>((event, emit) async {
      emit(ClienteLoading());
      try {
        final clientes = await clienteRepository.obtenerClientes();
        emit(ClienteLoaded(clientes));
      } catch (e) {
        emit(ClienteError('Error al cargar los clientes: $e'));
      }
    });

    on<AgregarCliente>((event, emit) async {
      emit(ClienteLoading());
      try {
        await clienteRepository.agregarCliente(event.cliente);
        final clientes = await clienteRepository.obtenerClientes();
        emit(ClienteLoaded(clientes));
      } catch (e) {
        emit(ClienteError('Error al agregar el cliente: $e'));
      }
    });

    on<ActualizarCliente>((event, emit) async {
      emit(ClienteLoading());
      try {
        await clienteRepository.actualizarCliente(event.cliente);
        final clientes = await clienteRepository.obtenerClientes();
        emit(ClienteLoaded(clientes));
      } catch (e) {
        emit(ClienteError('Error al actualizar el cliente: $e'));
      }
    });

    on<EliminarCliente>((event, emit) async {
      emit(ClienteLoading());
      try {
        await clienteRepository.eliminarCliente(event.id);
        final clientes = await clienteRepository.obtenerClientes();
        emit(ClienteLoaded(clientes));
      } catch (e) {
        emit(ClienteError('Error al eliminar el cliente: $e'));
      }
    });
  }
}
