import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/pedido.dart';

class PedidoRepository {
  final String baseUrl;

  PedidoRepository(this.baseUrl);

  // Procesar un pedido por cliente ID
  Future<Pedido> procesarPedido(int clienteId) async {
    final url = Uri.parse('$baseUrl/pedido/procesar/$clienteId');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return Pedido.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al procesar el pedido: ${response.statusCode}');
    }
  }

  // Descargar el PDF del pedido
  Future<List<int>> descargarPdf(int pedidoId) async {
    final url = Uri.parse('$baseUrl/pedido/pdf/$pedidoId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.bodyBytes; // Devuelve los bytes del archivo PDF
    } else {
      throw Exception('Error al descargar el PDF: ${response.statusCode}');
    }
  }
}
