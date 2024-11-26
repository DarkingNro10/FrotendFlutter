import '../models/categoria.dart';

abstract class CategoriaState {}

class CategoriaInitial extends CategoriaState {}

class CategoriaLoading extends CategoriaState {}

class CategoriaLoaded extends CategoriaState {
  final List<Categoria> categorias;

  CategoriaLoaded(this.categorias);
}

class CategoriaError extends CategoriaState {
  final String error;

  CategoriaError(this.error);
}
