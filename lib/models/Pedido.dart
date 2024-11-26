class Pedido {
  final int id;
  final int clienteId;
  final double totalAmount;

  Pedido({
    required this.id,
    required this.clienteId,
    required this.totalAmount,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      clienteId: json['clienteId'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );
  }
}
