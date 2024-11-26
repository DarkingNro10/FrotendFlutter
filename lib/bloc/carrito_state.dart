import '../models/carrito_item.dart';

abstract class CarritoState {}

class CarritoInitial extends CarritoState {}

class CarritoLoading extends CarritoState {}

class CarritoLoaded extends CarritoState {
  final List<CarritoItem> items;

  CarritoLoaded(this.items);
}

class CarritoTotal extends CarritoState {
  final double total;

  CarritoTotal(this.total);
}

class CarritoError extends CarritoState {
  final String error;

  CarritoError(this.error);
}
