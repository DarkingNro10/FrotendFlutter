import 'package:flutter/material.dart';

class AdminMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Cantidad de columnas
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildMenuCard(
              context,
              icon: Icons.inventory,
              label: 'Productos',
              route: '/productos',
            ),
            _buildMenuCard(
              context,
              icon: Icons.category,
              label: 'Categorías',
              route: '/categorias',
            ),
            _buildMenuCard(
              context,
              icon: Icons.person,
              label: 'Clientes',
              route: '/clientes',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
