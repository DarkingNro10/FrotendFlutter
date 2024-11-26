import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cliente_bloc.dart';
import '../bloc/cliente_event.dart';
import '../models/cliente.dart';

class EditarClienteScreen extends StatefulWidget {
  final Cliente cliente;

  const EditarClienteScreen({Key? key, required this.cliente}) : super(key: key);

  @override
  _EditarClienteScreenState createState() => _EditarClienteScreenState();
}

class _EditarClienteScreenState extends State<EditarClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;
  late String _dni;
  late String _direccion;
  late String _telefono;

  @override
  void initState() {
    super.initState();
    _nombre = widget.cliente.nombre;
    _dni = widget.cliente.dni;
    _direccion = widget.cliente.direccion;
    _telefono = widget.cliente.telefono.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                initialValue: _dni,
                decoration: InputDecoration(labelText: 'DNI'),
                onSaved: (value) => _dni = value!,
              ),
              TextFormField(
                initialValue: _direccion,
                decoration: InputDecoration(labelText: 'Dirección'),
                onSaved: (value) => _direccion = value!,
              ),
              TextFormField(
                initialValue: _telefono,
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
                      id: widget.cliente.id,
                      nombre: _nombre,
                      dni: _dni,
                      direccion: _direccion,
                      telefono: int.tryParse(_telefono) ?? 0,
                    );

                    context.read<ClienteBloc>().add(ActualizarCliente(cliente));

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
