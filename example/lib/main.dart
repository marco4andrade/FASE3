import 'package:flutter/material.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

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
      home: const MyHomePage(title: 'FakeStore API Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FakeStoreService service = FakeStoreService();
  String result = 'Presiona un botón para probar la API';

  Future<void> testProducts() async {
    try {
      final products = await service.getAllProducts();
      setState(() {
        result =
            'Productos encontrados: ${products.length}\n'
            'Primer producto: ${products.first.title}';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  Future<void> testUsers() async {
    try {
      final users = await service.getAllUsers();
      setState(() {
        result =
            'Usuarios encontrados: ${users.length}\n'
            'Primer usuario: ${users.first.name.firstName} ${users.first.name.lastName}';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  Future<void> testCarts() async {
    try {
      final carts = await service.getAllCarts();
      setState(() {
        result =
            'Carritos encontrados: ${carts.length}\n'
            'Primer carrito: ${carts.first.products.length} productos';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  Future<void> testCategories() async {
    try {
      final categories = await service.getCategories();
      setState(() {
        result =
            'Categorías encontradas: ${categories.length}\n'
            'Categorías: ${categories.join(', ')}';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  Future<void> testSingleProduct() async {
    try {
      final product = await service.getProduct(1);
      setState(() {
        result =
            'Producto específico (ID: 1):\n'
            'Título: ${product.title}\n'
            'Precio: \$${product.price}';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  Future<void> testProductsByCategory() async {
    try {
      final products = await service.getProductsInCategory('electronics');
      setState(() {
        result =
            'Productos en "electronics": ${products.length}\n'
            'Primer producto: ${products.first.title}';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  Future<void> testSingleUser() async {
    try {
      final user = await service.getUser(1);
      setState(() {
        result =
            'Usuario específico (ID: 1):\n'
            'Nombre: ${user.name.firstName} ${user.name.lastName}\n'
            'Email: ${user.email}';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  Future<void> testSingleCart() async {
    try {
      final cart = await service.getCart(1);
      setState(() {
        result =
            'Carrito específico (ID: 1):\n'
            'Productos: ${cart.products.length}\n'
            'Usuario ID: ${cart.userId}';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  Future<void> testUserCarts() async {
    try {
      final carts = await service.getUserCarts(1);
      setState(() {
        result =
            'Carritos del usuario 1: ${carts.length}\n'
            'Total productos: ${carts.fold(0, (sum, cart) => sum + cart.products.length)}';
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                  child: Text(
                    result,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: testProducts,
                child: const Text('Obtener Productos'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: testUsers,
                child: const Text('Obtener Usuarios'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: testCarts,
                child: const Text('Obtener Carritos'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: testCategories,
                child: const Text('Obtener Categorías'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: testSingleProduct,
                child: const Text('Producto Específico (ID: 1)'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: testProductsByCategory,
                child: const Text('Productos por Categoría'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: testSingleUser,
                child: const Text('Usuario Específico (ID: 1)'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: testSingleCart,
                child: const Text('Carrito Específico (ID: 1)'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: testUserCarts,
                child: const Text('Carritos de Usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
