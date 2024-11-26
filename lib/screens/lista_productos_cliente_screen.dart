import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/producto_bloc.dart';
import '../bloc/producto_event.dart';
import '../bloc/producto_state.dart';
import '../models/producto.dart';
import '../bloc/carrito_bloc.dart';
import '../bloc/carrito_event.dart';
import '../models/carrito_item.dart';

class ListaProductosClienteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Disparar el evento para obtener productos
    context.read<ProductoBloc>().add(ObtenerProductos());

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navegar a la pantalla de carrito
              Navigator.pushNamed(context, '/carrito');
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductoBloc, ProductoState>(
        builder: (context, state) {
          if (state is ProductoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductoLoaded) {
            final productos = state.productos;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return Card(
                  child: ListTile(
                    title: Text(producto.nombre),
                    subtitle: Text('Costo: \$${producto.costo}'),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        final carritoItem = CarritoItem(
                          id: 0,
                          productId: producto.id,
                          productName: producto.nombre,
                          productPrice: double.parse(producto.costo),
                          cantidad: 1,
                          subtotal: double.parse(producto.costo),
                          userId: 1, // Cambia esto por el ID real del usuario
                        );
                        context.read<CarritoBloc>().add(AgregarAlCarrito(carritoItem));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${producto.nombre} añadido al carrito')),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductoError) {
            return Center(child: Text('Error al cargar productos: ${state.error}'));
          }
          return Center(child: Text('No hay productos disponibles.'));
        },
      ),
    );
  }
}
