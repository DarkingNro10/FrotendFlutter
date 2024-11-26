import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla de Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar a la Vista Admin (Lista de Productos)
                Navigator.pushNamed(context, '/admin');
              },
              child: Text('Vista Admin'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes navegar a la Vista Cliente o agregar más lógica
                Navigator.pushNamed(context, '/productos_cliente');
              },
              child: Text('Vista Cliente'),
            ),
          ],
        ),
      ),
    );
  }
}
