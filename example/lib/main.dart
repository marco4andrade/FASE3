import 'package:flutter/material.dart';
/*
==================== EJEMPLO RÁPIDO (uso básico del paquete) ====================

import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

Future<void> main() async {
  final dataSource = FakeStoreRemoteDataSource();

  final productsRepo = ProductRepositoryImpl(dataSource: dataSource);
  final usersRepo    = UserRepositoryImpl(dataSource: dataSource);
  final cartsRepo    = CartRepositoryImpl(dataSource: dataSource);

  // Obtener productos (con parámetros opcionales)
  final products = await productsRepo.getAllProducts(limit: 5, sort: 'desc');
  print('Total productos: ${products.length}');
  print('Primero: ${products.first.title} (${products.first.price})');

  // Categorías
  final categories = await productsRepo.getCategories();
  print('Categorías: ${categories.join(', ')}');

  // Producto específico
  final p = await productsRepo.getProductById(1);
  print('Producto 1 => ${p.title}');

  // Usuarios
  final users = await usersRepo.getAllUsers(limit: 3);
  print('Primer usuario: ${users.first.name.fullName}');

  // Carritos
  final carts = await cartsRepo.getAllCarts();
  print('Carritos: ${carts.length}');
}

=================================================================================
La UI Flutter del ejemplo completo está en: presentation/pages/home_page.dart
Se incluye arquitectura mínima: use cases + controller + inyección manual.
*/

import 'presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FakeStore Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
