import 'package:dartz/dartz.dart';
import '../models/cart_model.dart';
import '../failures/failures.dart';

/// Contrato/Interface para el repositorio de carritos
abstract class CartRepository {
  /// Obtiene todos los carritos
  Future<Either<Failure, List<CartModel>>> getAllCarts({
    int? limit,
    String? sort,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Obtiene un carrito por su ID
  Future<Either<Failure, CartModel>> getCartById(int id);

  /// Obtiene los carritos de un usuario específico
  Future<Either<Failure, List<CartModel>>> getCartsByUserId(int userId);
}
