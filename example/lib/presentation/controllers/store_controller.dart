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

  Future<String> demoProducts() async {
    final products = await getAllProducts(limit: 5);
    return 'Productos: ${products.length}\nPrimer título: ${products.first.title}';
  }

  Future<String> demoCategories() async {
    final cats = await getCategories();
    return 'Categorías (${cats.length}): ${cats.join(', ')}';
  }

  Future<String> demoProduct() async {
    final p = await getProductById(1);
    return 'Producto 1 -> ${p.title} (${p.price})';
  }

  Future<String> demoProductsInCategory() async {
    final list = await getProductsByCategory('electronics');
    return 'Electronics: ${list.length}\nPrimero: ${list.first.title}';
  }

  Future<String> demoUsers() async {
    final users = await getAllUsers();
    return 'Usuarios: ${users.length}\nPrimero: ${users.first.name.fullName}';
  }

  Future<String> demoUser() async {
    final u = await getUserById(1);
    return 'User 1 -> ${u.name.fullName}';
  }

  Future<String> demoCarts() async {
    final carts = await getAllCarts();
    final totalProducts = carts.isEmpty ? 0 : carts.first.totalProducts;
    return 'Carritos: ${carts.length}\nPrimer carrito productos: $totalProducts';
  }

  Future<String> demoCart() async {
    final c = await getCartById(1);
    return 'Cart 1 -> productos: ${c.products.length}';
  }

  Future<String> demoUserCarts() async {
    final carts = await getCartsByUserId(1);
    final total = carts.fold<int>(0, (s, c) => s + c.products.length);
    return 'Carts de user 1: ${carts.length}\nTotal productos: $total';
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
    final u = await createUser(input);
    return 'Usuario creado -> id: ${u.id}\nusername: ${u.username}';
  }

  Future<String> demoLogin() async {
    // Credenciales de ejemplo de la documentación de fakestore
    const user = 'mor_2314';
    const pass = '83r5^_';
    final token = await loginUser(username: user, password: pass);
    return 'Login OK\nToken (truncado): ${token.substring(0, token.length > 25 ? 25 : token.length)}...';
  }

  // Métodos genéricos para uso desde formularios
  Future<UserModel> createUserCustom(CreateUserInput input) => createUser(input);
  Future<String> loginCustom(String username, String password) => loginUser(username: username, password: password);
}
