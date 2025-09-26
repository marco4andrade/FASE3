import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/get_products_by_category.dart';
import '../../domain/usecases/get_all_users.dart';
import '../../domain/usecases/get_user_by_id.dart';
import '../../domain/usecases/get_all_carts.dart';
import '../../domain/usecases/get_cart_by_id.dart';
import '../../domain/usecases/get_carts_by_user_id.dart';

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
}
