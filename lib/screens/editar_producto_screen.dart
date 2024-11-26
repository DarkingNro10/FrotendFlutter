import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/producto_bloc.dart';
import '../bloc/producto_event.dart';
import '../models/producto.dart';

class EditarProductoScreen extends StatefulWidget {
  final Producto producto;

  const EditarProductoScreen({Key? key, required this.producto}) : super(key: key);

  @override
  _EditarProductoScreenState createState() => _EditarProductoScreenState();
}

class _EditarProductoScreenState extends State<EditarProductoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;
  late String _costo;
  late int _categoriaId;
  String? _descripcion;

  @override
  void initState() {
    super.initState();
    _nombre = widget.producto.nombre;
    _costo = widget.producto.costo;
    _categoriaId = widget.producto.categoriaId;
    _descripcion = widget.producto.descripcion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nombre,
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => _nombre = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _costo,
                decoration: InputDecoration(labelText: 'Costo'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _costo = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el costo.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _categoriaId.toString(),
                decoration: InputDecoration(labelText: 'ID de Categoría'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _categoriaId = int.tryParse(value!) ?? 0,
              ),
              TextFormField(
                initialValue: _descripcion,
                decoration: InputDecoration(labelText: 'Descripción'),
                onSaved: (value) => _descripcion = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Crear el objeto Producto actualizado
                    final producto = Producto(
                      id: widget.producto.id,
                      nombre: _nombre,
                      costo: _costo,
                      categoriaId: _categoriaId,
                      descripcion: _descripcion,
                    );

                    // Disparar el evento para actualizar producto
                    context.read<ProductoBloc>().add(ActualizarProducto(producto));

                    // Regresar a la pantalla anterior
                    Navigator.pop(context);
                  }
                },
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
