import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/producto_bloc.dart';
import '../bloc/producto_event.dart';
import '../bloc/producto_state.dart';
import '../models/producto.dart';
import 'editar_producto_screen.dart';

class ListaProductosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dispara el evento para obtener productos al cargar la pantalla
    context.read<ProductoBloc>().add(ObtenerProductos());

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
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
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(producto.nombre),
                    subtitle: Text('Costo: ${producto.costo}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navegar a la pantalla para editar el producto
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditarProductoScreen(producto: producto),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Confirmar antes de eliminar
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Eliminar Producto'),
                                content: Text('¿Estás seguro de eliminar este producto?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<ProductoBloc>().add(EliminarProducto(producto.id));
                                      Navigator.pop(context);
                                    },
                                    child: Text('Eliminar'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductoError) {
            return Center(child: Text(state.error));
          }
          return Center(child: Text('No hay productos disponibles.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/agregar');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
