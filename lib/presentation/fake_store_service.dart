import 'package:http/http.dart' as http;

import '../domain/entities/product_entity.dart';
import '../domain/entities/user_entity.dart';
import '../domain/entities/cart_entity.dart';
import '../domain/usecases/product_usecases.dart';
import '../domain/usecases/user_usecases.dart';
import '../domain/usecases/cart_usecases.dart';
import '../data/datasources/fake_store_remote_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../data/repositories/user_repository_impl.dart';
import '../data/repositories/cart_repository_impl.dart';

/// Facade simple que oculta la complejidad de Clean Architecture
/// Esta es la clase que usan los desarrolladores finales
class FakeStoreService {
  // DataSource
  late final FakeStoreRemoteDataSource _dataSource;

  // Repositories
  late final ProductRepositoryImpl _productRepository;
  late final UserRepositoryImpl _userRepository;
  late final CartRepositoryImpl _cartRepository;

  // Use Cases
  late final GetAllProducts _getAllProducts;
  late final GetProductById _getProductById;
  late final GetCategories _getCategories;
  late final GetProductsByCategory _getProductsByCategory;

  late final GetAllUsers _getAllUsers;
  late final GetUserById _getUserById;
  late final LoginUser _loginUser;

  late final GetAllCarts _getAllCarts;
  late final GetCartById _getCartById;
  late final GetCartsByUserId _getCartsByUserId;

  /// Constructor que configura toda la arquitectura internamente
  FakeStoreService({http.Client? httpClient}) {
    // 1. Crear DataSource
    _dataSource = FakeStoreRemoteDataSource(httpClient: httpClient);

    // 2. Crear Repositories
    _productRepository = ProductRepositoryImpl(_dataSource);
    _userRepository = UserRepositoryImpl(_dataSource);
    _cartRepository = CartRepositoryImpl(_dataSource);

    // 3. Crear Use Cases
    _getAllProducts = GetAllProducts(_productRepository);
    _getProductById = GetProductById(_productRepository);
    _getCategories = GetCategories(_productRepository);
    _getProductsByCategory = GetProductsByCategory(_productRepository);

    _getAllUsers = GetAllUsers(_userRepository);
    _getUserById = GetUserById(_userRepository);
    _loginUser = LoginUser(_userRepository);

    _getAllCarts = GetAllCarts(_cartRepository);
    _getCartById = GetCartById(_cartRepository);
    _getCartsByUserId = GetCartsByUserId(_cartRepository);
  }

  /// Liberar recursos
  void dispose() {
    _dataSource.dispose();
  }

  // ===== API PÚBLICA SIMPLE =====

  // PRODUCTOS
  Future<List<ProductEntity>> getAllProducts({int? limit, String? sort}) {
    return _getAllProducts(limit: limit, sort: sort);
  }

  Future<ProductEntity> getProduct(int id) {
    return _getProductById(id);
  }

  Future<List<String>> getCategories() {
    return _getCategories();
  }

  Future<List<ProductEntity>> getProductsInCategory(
    String category, {
    int? limit,
    String? sort,
  }) {
    return _getProductsByCategory(category, limit: limit, sort: sort);
  }

  // USUARIOS
  Future<List<UserEntity>> getAllUsers({int? limit, String? sort}) {
    return _getAllUsers(limit: limit, sort: sort);
  }

  Future<UserEntity> getUser(int id) {
    return _getUserById(id);
  }

  Future<String> login(String username, String password) {
    return _loginUser(username, password);
  }

  // CARRITOS
  Future<List<CartEntity>> getAllCarts({
    int? limit,
    String? sort,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _getAllCarts(
      limit: limit,
      sort: sort,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<CartEntity> getCart(int id) {
    return _getCartById(id);
  }

  Future<List<CartEntity>> getUserCarts(int userId) {
    return _getCartsByUserId(userId);
  }
}
