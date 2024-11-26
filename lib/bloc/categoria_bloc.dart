import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/categoria.dart';
import '../repositories/categoria_repository.dart';
import 'categoria_event.dart';
import 'categoria_state.dart';

class CategoriaBloc extends Bloc<CategoriaEvent, CategoriaState> {
  final CategoriaRepository categoriaRepository;

  CategoriaBloc(this.categoriaRepository) : super(CategoriaInitial()) {
    on<ObtenerCategorias>((event, emit) async {
      emit(CategoriaLoading());
      try {
        final categorias = await categoriaRepository.obtenerCategorias();
        emit(CategoriaLoaded(categorias));
      } catch (e) {
        emit(CategoriaError('Error al cargar las categorías: $e'));
      }
    });

    on<AgregarCategoria>((event, emit) async {
      emit(CategoriaLoading());
      try {
        await categoriaRepository.agregarCategoria(event.categoria);
        final categorias = await categoriaRepository.obtenerCategorias();
        emit(CategoriaLoaded(categorias));
      } catch (e) {
        emit(CategoriaError('Error al agregar la categoría: $e'));
      }
    });

    on<ActualizarCategoria>((event, emit) async {
      emit(CategoriaLoading());
      try {
        await categoriaRepository.actualizarCategoria(event.id, event.categoria);
        final categorias = await categoriaRepository.obtenerCategorias();
        emit(CategoriaLoaded(categorias));
      } catch (e) {
        emit(CategoriaError('Error al actualizar la categoría: $e'));
      }
    });

    on<EliminarCategoria>((event, emit) async {
      emit(CategoriaLoading());
      try {
        await categoriaRepository.eliminarCategoria(event.id);
        final categorias = await categoriaRepository.obtenerCategorias();
        emit(CategoriaLoaded(categorias));
      } catch (e) {
        emit(CategoriaError('Error al eliminar la categoría: $e'));
      }
    });
  }
}
