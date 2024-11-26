class Cliente {
  final int id;
  final String nombre;
  final String dni;
  final String direccion;
  final int telefono;

  Cliente({
    required this.id,
    required this.nombre,
    required this.dni,
    required this.direccion,
    required this.telefono,
  });

  // Método para convertir JSON en un objeto Cliente
  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nombre: json['nombre'],
      dni: json['dni'],
      direccion: json['direccion'],
      telefono: json['telefono'],
    );
  }

  // Método para convertir un objeto Cliente a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'dni': dni,
      'direccion': direccion,
      'telefono': telefono,
    };
  }
}
