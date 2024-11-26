import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/categoria_bloc.dart';
import '../bloc/categoria_event.dart';
import '../bloc/categoria_state.dart';
import '../models/categoria.dart';

class ListaCategoriasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<CategoriaBloc>().add(ObtenerCategorias());

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorías'),
      ),
      body: BlocBuilder<CategoriaBloc, CategoriaState>(
        builder: (context, state) {
          if (state is CategoriaLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CategoriaLoaded) {
            final categorias = state.categorias;
            return ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                return Card(
                  child: ListTile(
                    title: Text(categoria.titulo),
                    subtitle: Text(categoria.descripcion),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navegar a pantalla de editar categoría
                            Navigator.pushNamed(context, '/editar_categoria', arguments: categoria);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context.read<CategoriaBloc>().add(EliminarCategoria(categoria.id));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is CategoriaError) {
            return Center(child: Text(state.error));
          }
          return Center(child: Text('No hay categorías disponibles.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/agregar_categoria');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
