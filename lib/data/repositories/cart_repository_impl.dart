import '../../domain/models/cart_model.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/fake_store_remote_datasource.dart';

/// Implementación concreta del repositorio de carritos
class CartRepositoryImpl implements CartRepository {
  final FakeStoreRemoteDataSource _ds;
  CartRepositoryImpl({FakeStoreRemoteDataSource? dataSource}) : _ds = dataSource ?? FakeStoreRemoteDataSource();

  FakeStoreRemoteDataSource get dataSource => _ds;

  @override
  Future<List<CartModel>> getAllCarts({
    int? limit,
    String? sort,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return _ds.getAllCarts(
      limit: limit,
      sort: sort,
      startDate: startDate?.toIso8601String().split('T')[0],
      endDate: endDate?.toIso8601String().split('T')[0],
    );
  }

  @override
  Future<CartModel> getCartById(int id) async {
    return _ds.getCartById(id);
  }

  @override
  Future<List<CartModel>> getCartsByUserId(int userId) async {
    return _ds.getCartsByUserId(userId);
  }
}
