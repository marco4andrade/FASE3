/// Representa un carrito de compra asociado a un usuario.
///
/// Normalmente cada carrito contiene una fecha (ISO 8601) y una lista de
/// productos con sus cantidades. La agregación de totales puede reutilizarse
/// para métricas simples en la UI.
class CartModel {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartProductModel> products;

  const CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  int get totalProducts =>
      products.fold(0, (sum, p) => sum + p.quantity);
}

/// Relación producto-cantidad dentro de un carrito.
///
/// - [productId]: Referencia al producto.
/// - [quantity]: Cantidad seleccionada para ese producto.
class CartProductModel {
  final int productId;
  final int quantity;

  const CartProductModel({required this.productId, required this.quantity});
}
