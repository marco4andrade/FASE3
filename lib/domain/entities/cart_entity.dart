/// Entidad pura del carrito (sin dependencias externas)
class CartEntity {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartProductEntity> products;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  /// Obtiene el número total de productos en el carrito
  int get totalProducts =>
      products.fold(0, (sum, product) => sum + product.quantity);

  @override
  String toString() {
    return 'CartEntity{id: $id, userId: $userId, totalProducts: $totalProducts}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Entidad del producto en carrito
class CartProductEntity {
  final int productId;
  final int quantity;

  const CartProductEntity({required this.productId, required this.quantity});

  @override
  String toString() {
    return 'CartProductEntity{productId: $productId, quantity: $quantity}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartProductEntity &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          quantity == other.quantity;

  @override
  int get hashCode => productId.hashCode ^ quantity.hashCode;
}
