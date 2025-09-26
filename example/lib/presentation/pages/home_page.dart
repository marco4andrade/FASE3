import 'package:flutter/material.dart';
import '../../core/di/injection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ExampleInjector _injector;
  String result = 'Presiona un botón para probar la API';

  @override
  void initState() {
    super.initState();
    _injector = ExampleInjector();
  }

  Future<void> _run(Future<String> Function() op) async {
    setState(() => result = 'Cargando...');
    try {
      final text = await op();
      setState(() => result = text);
    } catch (e) {
      setState(() => result = 'Error: $e');
    }
  }

  void _testProducts() => _run(_injector.storeController.demoProducts);
  void _testCategories() => _run(_injector.storeController.demoCategories);
  void _testSingleProduct() => _run(_injector.storeController.demoProduct);
  void _testProductsByCategory() => _run(_injector.storeController.demoProductsInCategory);
  void _testUsers() => _run(_injector.storeController.demoUsers);
  void _testSingleUser() => _run(_injector.storeController.demoUser);
  void _testCarts() => _run(_injector.storeController.demoCarts);
  void _testSingleCart() => _run(_injector.storeController.demoCart);
  void _testUserCarts() => _run(_injector.storeController.demoUserCarts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FakeStore API Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(result, style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _testProducts, child: const Text('Obtener Productos')),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _testUsers, child: const Text('Obtener Usuarios')),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _testCarts, child: const Text('Obtener Carritos')),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _testCategories, child: const Text('Obtener Categorías')),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _testSingleProduct, child: const Text('Producto Específico (ID: 1)')),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _testProductsByCategory, child: const Text('Productos por Categoría')),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _testSingleUser, child: const Text('Usuario Específico (ID: 1)')),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _testSingleCart, child: const Text('Carrito Específico (ID: 1)')),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _testUserCarts, child: const Text('Carritos de Usuario')),
            ],
          ),
        ),
      ),
    );
  }
}
