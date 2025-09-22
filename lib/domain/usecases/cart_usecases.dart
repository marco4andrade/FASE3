import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

/// Caso de uso para obtener todos los carritos
class GetAllCarts {
  final CartRepository repository;

  GetAllCarts(this.repository);

  Future<List<CartEntity>> call({
    int? limit,
    String? sort,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return repository.getAllCarts(
      limit: limit,
      sort: sort,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

/// Caso de uso para obtener un carrito específico
class GetCartById {
  final CartRepository repository;

  GetCartById(this.repository);

  Future<CartEntity> call(int id) {
    return repository.getCartById(id);
  }
}

/// Caso de uso para obtener carritos de un usuario
class GetCartsByUserId {
  final CartRepository repository;

  GetCartsByUserId(this.repository);

  Future<List<CartEntity>> call(int userId) {
    return repository.getCartsByUserId(userId);
  }
}
