import '../entities/cart_entity.dart';

/// Contrato/Interface para el repositorio de carritos
abstract class CartRepository {
  /// Obtiene todos los carritos
  Future<List<CartEntity>> getAllCarts({
    int? limit,
    String? sort,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Obtiene un carrito por su ID
  Future<CartEntity> getCartById(int id);

  /// Obtiene los carritos de un usuario específico
  Future<List<CartEntity>> getCartsByUserId(int userId);
}
