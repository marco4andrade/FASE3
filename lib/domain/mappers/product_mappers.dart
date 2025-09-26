import '../models/product_model.dart';

/// Extensión utilitaria para serializar un [ProductModel] a un `Map<String,dynamic>`.
/// Principalmente usada en tests o si se requiere reenviar datos.
/// No realiza validaciones adicionales.

extension ProductMap on ProductModel {
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': imageUrl,
        'rating': {'rate': rating.rate, 'count': rating.count},
      };
}

/// Mapeador desde un `Map<String,dynamic>` (JSON decodificado) hacia [ProductModel].
///
/// Consideraciones:
/// - Convierte tipos numéricos robustamente usando `num` -> `int` / `double`.
/// - Si campos faltan, aplica valores por defecto (strings vacíos o cero).
/// - Si la sección `rating` no existe, crea un rating neutro (0.0 / 0).
class ProductMapper {
  static ProductModel fromMap(Map<String, dynamic> map) {
    final ratingMap = map['rating'] as Map<String, dynamic>?;
    return ProductModel(
      id: (map['id'] as num).toInt(),
      title: (map['title'] ?? '') as String,
      price: (map['price'] as num).toDouble(),
      description: (map['description'] ?? '') as String,
      category: (map['category'] ?? '') as String,
      imageUrl: (map['image'] ?? '') as String,
      rating: RatingModel(
        rate: (ratingMap?['rate'] as num?)?.toDouble() ?? 0.0,
        count: (ratingMap?['count'] as num?)?.toInt() ?? 0,
      ),
    );
  }
}
