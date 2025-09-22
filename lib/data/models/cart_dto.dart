import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/cart_entity.dart';

part 'cart_dto.g.dart';

/// DTO para carritos desde la API
@JsonSerializable()
class CartDto {
  final int id;
  final int userId;
  final String date;
  final List<CartProductDto> products;

  const CartDto({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartDtoToJson(this);

  /// Mapper: DTO a Entidad
  CartEntity toEntity() {
    return CartEntity(
      id: id,
      userId: userId,
      date: DateTime.tryParse(date) ?? DateTime.now(),
      products: products.map((p) => p.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class CartProductDto {
  final int productId;
  final int quantity;

  const CartProductDto({required this.productId, required this.quantity});

  factory CartProductDto.fromJson(Map<String, dynamic> json) =>
      _$CartProductDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartProductDtoToJson(this);

  CartProductEntity toEntity() {
    return CartProductEntity(productId: productId, quantity: quantity);
  }
}
