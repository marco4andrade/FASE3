import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/fake_store_remote_datasource.dart';

/// Implementación concreta del repositorio de carritos
class CartRepositoryImpl implements CartRepository {
  final FakeStoreRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CartEntity>> getAllCarts({
    int? limit,
    String? sort,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final cartDtos = await _remoteDataSource.getAllCarts(
      limit: limit,
      sort: sort,
      startDate: startDate?.toIso8601String().split('T')[0],
      endDate: endDate?.toIso8601String().split('T')[0],
    );
    return cartDtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<CartEntity> getCartById(int id) async {
    final cartDto = await _remoteDataSource.getCartById(id);
    return cartDto.toEntity();
  }

  @override
  Future<List<CartEntity>> getCartsByUserId(int userId) async {
    final cartDtos = await _remoteDataSource.getCartsByUserId(userId);
    return cartDtos.map((dto) => dto.toEntity()).toList();
  }
}
