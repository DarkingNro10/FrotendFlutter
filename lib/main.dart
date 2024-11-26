import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/producto_bloc.dart';
import 'bloc/categoria_bloc.dart';
import 'bloc/cliente_bloc.dart';
import 'bloc/carrito_bloc.dart';
import 'models/categoria.dart';
import 'models/cliente.dart';
import 'repositories/producto_repository.dart';
import 'repositories/categoria_repository.dart';
import 'repositories/cliente_repository.dart';
import 'repositories/carrito_repository.dart';
import 'services/api_service.dart';
import 'screens/lista_productos_screen.dart';
import 'screens/agregar_producto_screen.dart';
import 'screens/inicio_screen.dart';
import 'screens/admin_menu_screen.dart';
import 'screens/lista_categorias_screen.dart';
import 'screens/agregar_categoria_screen.dart';
import 'screens/editar_categoria_screen.dart';
import 'screens/lista_clientes_screen.dart';
import 'screens/agregar_cliente_screen.dart';
import 'screens/editar_cliente_screen.dart';
import 'screens/lista_productos_cliente_screen.dart';
import 'screens/carrito_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Crear instancia de ApiService
    final apiService = ApiService('http://192.168.1.33:8080'); // Cambia la URL según tu servidor
    final productoRepository = ProductoRepository(apiService);
    final categoriaRepository = CategoriaRepository(apiService);
    final clienteRepository = ClienteRepository(apiService);
    final carritoRepository = CarritoRepository(apiService);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductoBloc(productoRepository),
        ),
        BlocProvider(
          create: (context) => CategoriaBloc(categoriaRepository),
        ),
        BlocProvider(
          create: (context) => ClienteBloc(clienteRepository),
        ),
        BlocProvider(
          create: (context) => CarritoBloc(carritoRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Gestión de Productos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/', // Ruta inicial
        routes: {
          // Ruta para la pantalla de inicio
          '/': (context) => InicioScreen(),
          // Ruta para la Vista Admin (Menú)
          '/admin': (context) => AdminMenuScreen(),
          // Ruta para la Vista de Productos
          '/productos': (context) => ListaProductosScreen(),
          '/agregar': (context) => AgregarProductoScreen(),
          // Rutas para Categorías
          '/categorias': (context) => ListaCategoriasScreen(),
          '/agregar_categoria': (context) => AgregarCategoriaScreen(),
          '/editar_categoria': (context) => EditarCategoriaScreen(
            categoria: ModalRoute.of(context)!.settings.arguments as Categoria,
          ),
          // Rutas para Clientes
          '/clientes': (context) => ListaClientesScreen(),
          '/agregar_cliente': (context) => AgregarClienteScreen(),
          '/editar_cliente': (context) => EditarClienteScreen(
            cliente: ModalRoute.of(context)!.settings.arguments as Cliente,
          ),
          // Rutas para Vista Cliente y Carrito
          '/productos_cliente': (context) => ListaProductosClienteScreen(),
          '/carrito': (context) => CarritoScreen(userId: 1), // Cambia el ID del usuario actual según corresponda
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => InicioScreen(),
        ),
      ),
    );
  }
}
