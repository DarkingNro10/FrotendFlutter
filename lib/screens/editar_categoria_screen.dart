import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/categoria_bloc.dart';
import '../bloc/categoria_event.dart';
import '../models/categoria.dart';

class EditarCategoriaScreen extends StatefulWidget {
  final Categoria categoria;

  const EditarCategoriaScreen({Key? key, required this.categoria}) : super(key: key);

  @override
  _EditarCategoriaScreenState createState() => _EditarCategoriaScreenState();
}

class _EditarCategoriaScreenState extends State<EditarCategoriaScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _titulo;
  late String _descripcion;
  late String _etiqueta;
  late String _color;

  @override
  void initState() {
    super.initState();
    _titulo = widget.categoria.titulo;
    _descripcion = widget.categoria.descripcion;
    _etiqueta = widget.categoria.etiqueta;
    _color = widget.categoria.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _titulo,
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
                initialValue: _descripcion,
                decoration: InputDecoration(labelText: 'Descripción'),
                onSaved: (value) => _descripcion = value!,
              ),
              TextFormField(
                initialValue: _etiqueta,
                decoration: InputDecoration(labelText: 'Etiqueta'),
                onSaved: (value) => _etiqueta = value!,
              ),
              TextFormField(
                initialValue: _color,
                decoration: InputDecoration(labelText: 'Color'),
                onSaved: (value) => _color = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final categoria = Categoria(
                      id: widget.categoria.id,
                      titulo: _titulo,
                      descripcion: _descripcion,
                      etiqueta: _etiqueta,
                      color: _color,
                    );

                    context.read<CategoriaBloc>().add(ActualizarCategoria(categoria.id, categoria));

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
