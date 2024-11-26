import 'package:bloc/bloc.dart';
import '../models/producto.dart';
import '../repositories/producto_repository.dart';
import 'producto_event.dart';
import 'producto_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  final ProductoRepository productoRepository;

  ProductoBloc(this.productoRepository) : super(ProductoInitial()) {
    // Evento para obtener productos
    on<ObtenerProductos>((event, emit) async {
      emit(ProductoLoading());
      try {
        final productos = await productoRepository.obtenerProductos();
        emit(ProductoLoaded(productos));
      } catch (e) {
        emit(ProductoError('Error al cargar los productos'));
      }
    });

    // Evento para agregar un producto
    on<AgregarProducto>((event, emit) async {
      emit(ProductoLoading());
      try {
        await productoRepository.agregarProducto(event.producto);
        final productos = await productoRepository.obtenerProductos();
        emit(ProductoLoaded(productos));
      } catch (e) {
        emit(ProductoError('Error al agregar el producto'));
      }
    });
    // Evento para actualizar un producto
    on<ActualizarProducto>((event, emit) async {
      emit(ProductoLoading());
      try {
        await productoRepository.actualizarProducto(event.producto);
        final productos = await productoRepository.obtenerProductos();
        emit(ProductoLoaded(productos));
      } catch (e) {
        emit(ProductoError('Error al actualizar el producto: ${e.toString()}'));
      }
    });

// Evento para eliminar un producto
    on<EliminarProducto>((event, emit) async {
      emit(ProductoLoading());
      try {
        await productoRepository.eliminarProducto(event.id);
        final productos = await productoRepository.obtenerProductos();
        emit(ProductoLoaded(productos));
      } catch (e) {
        emit(ProductoError('Error al eliminar el producto: ${e.toString()}'));
      }
    });

  }

}
