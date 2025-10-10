import 'package:dartz/dartz.dart';
import '../models/product_model.dart';
import '../failures/failures.dart';

/// Contrato/Interface para el repositorio de productos
/// Define QUÉ se puede hacer, no CÓMO se hace
abstract class ProductRepository {
  /// Obtiene todos los productos
  Future<Either<Failure, List<ProductModel>>> getAllProducts({int? limit, String? sort});

  /// Obtiene un producto por su ID
  Future<Either<Failure, ProductModel>> getProductById(int id);

  /// Obtiene todas las categorías disponibles
  Future<Either<Failure, List<String>>> getCategories();

  /// Obtiene productos de una categoría específica
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  });
}
