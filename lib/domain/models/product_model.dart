/// Representa un producto obtenido desde la Fake Store API.
///
/// Contiene la información principal que puede mostrarse en una UI o procesarse
/// en lógica de negocio. Es inmutable y seguro para usar en tests.
///
/// Campos clave:
/// - [id]: Identificador único.
/// - [title]: Nombre comercial del producto.
/// - [price]: Precio en formato decimal.
/// - [description]: Descripción extendida.
/// - [category]: Categoría textual provista por la API.
/// - [imageUrl]: URL de la imagen del producto.
/// - [rating]: Información de calificación agregada.
class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final RatingModel rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
  });

  @override
  String toString() => 'ProductModel(id: $id, title: $title)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProductModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Calificación agregada del producto.
///
/// - [rate]: Puntuación promedio.
/// - [count]: Número de evaluaciones.
class RatingModel {
  final double rate;
  final int count;

  const RatingModel({required this.rate, required this.count});

  @override
  String toString() => 'RatingModel(rate: $rate, count: $count)';
}
