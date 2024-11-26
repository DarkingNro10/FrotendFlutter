import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cliente_bloc.dart';
import '../bloc/cliente_event.dart';
import '../bloc/cliente_state.dart';
import '../models/cliente.dart';

class ListaClientesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ClienteBloc>().add(ObtenerClientes());

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
      ),
      body: BlocBuilder<ClienteBloc, ClienteState>(
        builder: (context, state) {
          if (state is ClienteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ClienteLoaded) {
            final clientes = state.clientes;
            return ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];
                return Card(
                  child: ListTile(
                    title: Text(cliente.nombre),
                    subtitle: Text('DNI: ${cliente.dni}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navegar a pantalla de editar cliente
                            Navigator.pushNamed(context, '/editar_cliente', arguments: cliente);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context.read<ClienteBloc>().add(EliminarCliente(cliente.id));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ClienteError) {
            return Center(child: Text(state.error));
          }
          return Center(child: Text('No hay clientes disponibles.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/agregar_cliente');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
