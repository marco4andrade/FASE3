import '../models/cart_model.dart';

/// Convierte un mapa JSON de carrito en un [CartModel].
///
/// Características:
/// - Convierte cada entrada de `products` en [CartProductModel].
/// - Si la fecha es inválida o nula, usa `DateTime.now()` como fallback.
/// - Maneja lista de productos nula devolviendo lista vacía (no null).
class CartMapper {
  static CartModel fromMap(Map<String, dynamic> map) {
    final list = map['products'] as List<dynamic>?;
    return CartModel(
      id: (map['id'] as num).toInt(),
      userId: (map['userId'] as num).toInt(),
      date: DateTime.tryParse((map['date'] ?? '') as String) ?? DateTime.now(),
      products: list != null
          ? list
              .map((e) => CartProductModel(
                    productId: (e['productId'] as num).toInt(),
                    quantity: (e['quantity'] as num).toInt(),
                  ))
              .toList()
          : <CartProductModel>[],
    );
  }
}
