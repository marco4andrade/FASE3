/// Entidad pura del producto (sin dependencias externas)
class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final RatingEntity rating;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
  });

  @override
  String toString() {
    return 'ProductEntity{id: $id, title: $title, price: $price, category: $category}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Entidad de calificación
class RatingEntity {
  final double rate;
  final int count;

  const RatingEntity({required this.rate, required this.count});

  @override
  String toString() {
    return 'RatingEntity{rate: $rate, count: $count}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingEntity &&
          runtimeType == other.runtimeType &&
          rate == other.rate &&
          count == other.count;

  @override
  int get hashCode => rate.hashCode ^ count.hashCode;
}
