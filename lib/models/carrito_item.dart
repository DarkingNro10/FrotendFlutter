class CarritoItem {
  final int id;
  final int productId;
  final String productName;
  final double productPrice;
  final int cantidad;
  final double subtotal;
  final int userId;

  CarritoItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.cantidad,
    required this.subtotal,
    required this.userId,
  });

  factory CarritoItem.fromJson(Map<String, dynamic> json) {
    return CarritoItem(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      productPrice: (json['productPrice'] as num).toDouble(),
      cantidad: json['cantidad'],
      subtotal: (json['subtotal'] as num).toDouble(),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'cantidad': cantidad,
      'subtotal': subtotal,
      'userId': userId,
    };
  }
}
