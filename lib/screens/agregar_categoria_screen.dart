import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/categoria_bloc.dart';
import '../bloc/categoria_event.dart';
import '../models/categoria.dart';

class AgregarCategoriaScreen extends StatefulWidget {
  @override
  _AgregarCategoriaScreenState createState() => _AgregarCategoriaScreenState();
}

class _AgregarCategoriaScreenState extends State<AgregarCategoriaScreen> {
  final _formKey = GlobalKey<FormState>();
  String _titulo = '';
  String _descripcion = '';
  String _etiqueta = '';
  String _color = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                onSaved: (value) => _titulo = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                onSaved: (value) => _descripcion = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Etiqueta'),
                onSaved: (value) => _etiqueta = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Color'),
                onSaved: (value) => _color = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final categoria = Categoria(
                      id: 0, // ID generado por el backend
                      titulo: _titulo,
                      descripcion: _descripcion,
                      etiqueta: _etiqueta,
                      color: _color,
                    );

                    context.read<CategoriaBloc>().add(AgregarCategoria(categoria));

                    Navigator.pop(context);
                  }
                },
                child: Text('Agregar Categoría'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
