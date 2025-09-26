import '../models/cart_model.dart';

/// Contrato/Interface para el repositorio de carritos
abstract class CartRepository {
  /// Obtiene todos los carritos
  Future<List<CartModel>> getAllCarts({
    int? limit,
    String? sort,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Obtiene un carrito por su ID
  Future<CartModel> getCartById(int id);

  /// Obtiene los carritos de un usuario específico
  Future<List<CartModel>> getCartsByUserId(int userId);
}
