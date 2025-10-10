import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/get_products_by_category.dart';
import '../../domain/usecases/get_all_users.dart';
import '../../domain/usecases/get_user_by_id.dart';
import '../../domain/usecases/get_all_carts.dart';
import '../../domain/usecases/get_cart_by_id.dart';
import '../../domain/usecases/get_carts_by_user_id.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/login_user.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

/// Controlador simple para orquestar casos de uso.
/// Ahora maneja Either para mejor control de errores.
class StoreController {
  final GetAllProducts getAllProducts;
  final GetProductById getProductById;
  final GetCategories getCategories;
  final GetProductsByCategory getProductsByCategory;
  final GetAllUsers getAllUsers;
  final GetUserById getUserById;
  final GetAllCarts getAllCarts;
  final GetCartById getCartById;
  final GetCartsByUserId getCartsByUserId;
  final CreateUser createUser;
  final LoginUser loginUser;

  StoreController({
    required this.getAllProducts,
    required this.getProductById,
    required this.getCategories,
    required this.getProductsByCategory,
    required this.getAllUsers,
    required this.getUserById,
    required this.getAllCarts,
    required this.getCartById,
    required this.getCartsByUserId,
    required this.createUser,
    required this.loginUser,
  });

  /// Convierte un Either en un String para mostrar en la UI
  String _eitherToString<T>(Either<Failure, T> either, String Function(T) onSuccess) {
    return either.fold(
      (failure) => 'Error: ${failure.message}',
      onSuccess,
    );
  }

  Future<String> demoProducts() async {
    final result = await getAllProducts(limit: 5);
    return _eitherToString(result, (products) =>
        'Productos: ${products.length}\nPrimer título: ${products.first.title}');
  }

  Future<String> demoCategories() async {
    final result = await getCategories();
    return _eitherToString(result, (cats) =>
        'Categorías (${cats.length}): ${cats.join(', ')}');
  }

  Future<String> demoProduct() async {
    final result = await getProductById(1);
    return _eitherToString(result, (p) =>
        'Producto 1 -> ${p.title} (\$${p.price})');
  }

  Future<String> demoProductsInCategory() async {
    final result = await getProductsByCategory('electronics');
    return _eitherToString(result, (list) =>
        'Electronics: ${list.length}\nPrimero: ${list.first.title}');
  }

  Future<String> demoUsers() async {
    final result = await getAllUsers();
    return _eitherToString(result, (users) =>
        'Usuarios: ${users.length}\nPrimero: ${users.first.name.fullName}');
  }

  Future<String> demoUser() async {
    final result = await getUserById(1);
    return _eitherToString(result, (u) =>
        'User 1 -> ${u.name.fullName}');
  }

  Future<String> demoCarts() async {
    final result = await getAllCarts();
    return _eitherToString(result, (carts) {
      final totalProducts = carts.isEmpty ? 0 : carts.first.totalProducts;
      return 'Carritos: ${carts.length}\nPrimer carrito productos: $totalProducts';
    });
  }

  Future<String> demoCart() async {
    final result = await getCartById(1);
    return _eitherToString(result, (c) =>
        'Cart 1 -> productos: ${c.products.length}');
  }

  Future<String> demoUserCarts() async {
    final result = await getCartsByUserId(1);
    return _eitherToString(result, (carts) {
      final total = carts.fold<int>(0, (s, c) => s + c.products.length);
      return 'Carts de user 1: ${carts.length}\nTotal productos: $total';
    });
  }

  Future<String> demoCreateUser() async {
    final input = CreateUserInput(
      email: 'demo_${DateTime.now().millisecondsSinceEpoch}@example.com',
      username: 'demoUser${DateTime.now().millisecondsSinceEpoch % 10000}',
      password: 'DemoPass123',
      firstName: 'Demo',
      lastName: 'User',
      city: 'DemoCity',
      street: 'DemoStreet',
      number: 1,
      zipCode: '00000',
      geoLat: '0',
      geoLong: '0',
      phone: '000-000',
    );
    final result = await createUser(input);
    return _eitherToString(result, (u) =>
        'Usuario creado -> id: ${u.id}\nusername: ${u.username}');
  }

  Future<String> demoLogin() async {
    // Credenciales de ejemplo de la documentación de fakestore
    const user = 'mor_2314';
    const pass = '83r5^_';
    final result = await loginUser(username: user, password: pass);
    return _eitherToString(result, (token) =>
        'Login OK\nToken (truncado): ${token.substring(0, token.length > 25 ? 25 : token.length)}...');
  }

  // Métodos genéricos para uso desde formularios - ahora manejan Either
  Future<UserModel> createUserCustom(CreateUserInput input) async {
    final result = await createUser(input);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (user) => user,
    );
  }

  Future<String> loginCustom(String username, String password) async {
    final result = await loginUser(username: username, password: password);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (token) => token,
    );
  }
}
