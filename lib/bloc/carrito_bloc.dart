import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/carrito_item.dart';
import '../repositories/carrito_repository.dart';
import 'carrito_event.dart';
import 'carrito_state.dart';

class CarritoBloc extends Bloc<CarritoEvent, CarritoState> {
  final CarritoRepository carritoRepository;

  CarritoBloc(this.carritoRepository) : super(CarritoInitial()) {
    on<ObtenerCarrito>((event, emit) async {
      emit(CarritoLoading());
      try {
        // Cargar los ítems del carrito
        final items = await carritoRepository.obtenerCarrito(event.userId);
        emit(CarritoLoaded(items));
      } catch (e) {
        emit(CarritoError('Error al cargar el carrito: $e'));
      }
    });

    on<AgregarAlCarrito>((event, emit) async {
      emit(CarritoLoading());
      try {
        // Agregar el ítem al carrito
        await carritoRepository.agregarAlCarrito(event.item);

        // Recargar los ítems del carrito
        final items = await carritoRepository.obtenerCarrito(event.item.userId);
        emit(CarritoLoaded(items));
      } catch (e) {
        emit(CarritoError('Error al agregar al carrito: $e'));
      }
    });

    on<EliminarDelCarrito>((event, emit) async {
      emit(CarritoLoading());
      try {
        // Eliminar el ítem del carrito
        await carritoRepository.eliminarDelCarrito(event.id);

        // Recargar los ítems del carrito
        final items = await carritoRepository.obtenerCarrito(event.userId);
        emit(CarritoLoaded(items));
      } catch (e) {
        emit(CarritoError('Error al eliminar del carrito: $e'));
      }
    });

    on<ObtenerTotalCarrito>((event, emit) async {
      try {
        // Obtener el total del carrito desde el backend
        final total = await carritoRepository.obtenerTotalCarrito(event.userId);

        // Emitir el estado con el total
        emit(CarritoTotal(total));
      } catch (e) {
        emit(CarritoError('Error al obtener el total del carrito: $e'));
      }
    });

  }
}
