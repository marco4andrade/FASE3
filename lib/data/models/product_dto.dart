import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/product_entity.dart';

part 'product_dto.g.dart';

/// DTO (Data Transfer Object) para productos desde la API
@JsonSerializable()
class ProductDto {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingDto rating;

  const ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  /// Convierte desde JSON de la API
  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  /// Convierte a JSON para la API
  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  /// Mapper: Convierte DTO a Entidad del dominio
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      imageUrl: image,
      rating: rating.toEntity(),
    );
  }
}

/// DTO para calificaciones
@JsonSerializable()
class RatingDto {
  final double rate;
  final int count;

  const RatingDto({required this.rate, required this.count});

  factory RatingDto.fromJson(Map<String, dynamic> json) =>
      _$RatingDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RatingDtoToJson(this);

  /// Mapper: Convierte DTO a Entidad
  RatingEntity toEntity() {
    return RatingEntity(rate: rate, count: count);
  }
}
