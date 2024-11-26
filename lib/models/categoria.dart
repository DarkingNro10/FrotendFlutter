class Categoria {
  final int id;
  final String titulo;
  final String descripcion;
  final String etiqueta;
  final String color;

  Categoria({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.etiqueta,
    required this.color,
  });

  // Método para convertir JSON en un objeto Categoria
  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripccion'], // Coincide con el campo en el backend
      etiqueta: json['etiqueta'],
      color: json['color'],
    );
  }

  // Método para convertir un objeto Categoria a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripccion': descripcion,
      'etiqueta': etiqueta,
      'color': color,
    };
  }
}
