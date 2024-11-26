import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cliente_bloc.dart';
import '../bloc/cliente_event.dart';
import '../models/cliente.dart';

class AgregarClienteScreen extends StatefulWidget {
  @override
  _AgregarClienteScreenState createState() => _AgregarClienteScreenState();
}

class _AgregarClienteScreenState extends State<AgregarClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _dni = '';
  String _direccion = '';
  String _telefono = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
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
                decoration: InputDecoration(labelText: 'DNI'),
                onSaved: (value) => _dni = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dirección'),
                onSaved: (value) => _direccion = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _telefono = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final cliente = Cliente(
                      id: 0, // ID generado por el backend
                      nombre: _nombre,
                      dni: _dni,
                      direccion: _direccion,
                      telefono: int.tryParse(_telefono) ?? 0,
                    );

                    context.read<ClienteBloc>().add(AgregarCliente(cliente));

                    Navigator.pop(context);
                  }
                },
                child: Text('Agregar Cliente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
