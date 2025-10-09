import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

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
import '../../presentation/controllers/store_controller.dart';

/// Configuración manual simple (sin paquetes de DI) para el ejemplo.
class ExampleInjector {
  late final FakeStoreRemoteDataSource _ds;
  late final ProductRepositoryImpl _productRepo;
  late final UserRepositoryImpl _userRepo;
  late final CartRepositoryImpl _cartRepo;

  late final GetAllProducts getAllProducts;
  late final GetCategories getCategories;
  late final GetProductById getProductById;
  late final GetProductsByCategory getProductsByCategory;
  late final GetAllUsers getAllUsers;
  late final GetUserById getUserById;
  late final GetAllCarts getAllCarts;
  late final GetCartById getCartById;
  late final GetCartsByUserId getCartsByUserId;
  late final CreateUser createUser;
  late final LoginUser loginUser;

  late final StoreController storeController;

  ExampleInjector() {
    _ds = FakeStoreRemoteDataSource();
    _productRepo = ProductRepositoryImpl(dataSource: _ds);
    _userRepo = UserRepositoryImpl(dataSource: _ds);
    _cartRepo = CartRepositoryImpl(dataSource: _ds);

    getAllProducts = GetAllProducts(_productRepo);
    getCategories = GetCategories(_productRepo);
    getProductById = GetProductById(_productRepo);
    getProductsByCategory = GetProductsByCategory(_productRepo);

    getAllUsers = GetAllUsers(_userRepo);
    getUserById = GetUserById(_userRepo);

    getAllCarts = GetAllCarts(_cartRepo);
    getCartById = GetCartById(_cartRepo);
    getCartsByUserId = GetCartsByUserId(_cartRepo);

  createUser = CreateUser(_userRepo);
  loginUser = LoginUser(_userRepo);

    storeController = StoreController(
      getAllProducts: getAllProducts,
      getProductById: getProductById,
      getCategories: getCategories,
      getProductsByCategory: getProductsByCategory,
      getAllUsers: getAllUsers,
      getUserById: getUserById,
      getAllCarts: getAllCarts,
      getCartById: getCartById,
      getCartsByUserId: getCartsByUserId,
      createUser: createUser,
      loginUser: loginUser,
    );
  }
}
