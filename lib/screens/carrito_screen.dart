import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../bloc/carrito_bloc.dart';
import '../bloc/carrito_event.dart';
import '../bloc/carrito_state.dart';
import '../repositories/pedido_repository.dart';

class CarritoScreen extends StatelessWidget {
  final int userId;

  CarritoScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    context.read<CarritoBloc>().add(ObtenerCarrito(userId));

    final pedidoRepository = PedidoRepository('http://192.168.1.33:8080');

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: BlocConsumer<CarritoBloc, CarritoState>(
        listener: (context, state) {
          if (state is CarritoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is CarritoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CarritoLoaded) {
            final items = state.items;
            if (items.isEmpty) {
              return Center(child: Text('El carrito está vacío.'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.productName),
                        subtitle: Text(
                          'Cantidad: ${item.cantidad}, Subtotal: \$${item.subtotal.toStringAsFixed(2)}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context.read<CarritoBloc>().add(
                              EliminarDelCarrito(item.id, userId),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Procesar el pedido
                      final pedido = await pedidoRepository.procesarPedido(userId);

                      // Descargar el PDF
                      final pdfBytes = await pedidoRepository.descargarPdf(pedido.id);

                      // Guardar el PDF
                      final rutaArchivo = await _guardarPdf(
                        pdfBytes,
                        'factura_pedido_${pedido.id}.pdf',
                      );

                      // Abrir el PDF
                      await _abrirPdf(rutaArchivo);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Factura generada con éxito')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al generar la factura: $e')),
                      );
                    }
                  },
                  child: Text('Generar Factura'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ],
            );
          }
          return Center(child: Text('El carrito está vacío.'));
        },
      ),
    );
  }

  Future<String> _guardarPdf(List<int> bytes, String nombreArchivo) async {
    final directorio = await getApplicationDocumentsDirectory();
    final archivo = File('${directorio.path}/$nombreArchivo');
    await archivo.writeAsBytes(bytes);
    return archivo.path; // Devuelve la ruta del archivo
  }

  Future<void> _abrirPdf(String rutaArchivo) async {
    await OpenFile.open(rutaArchivo);
  }
}
