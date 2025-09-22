import '../entities/product_entity.dart';

/// Contrato/Interface para el repositorio de productos
/// Define QUÉ se puede hacer, no CÓMO se hace
abstract class ProductRepository {
  /// Obtiene todos los productos
  Future<List<ProductEntity>> getAllProducts({int? limit, String? sort});

  /// Obtiene un producto por su ID
  Future<ProductEntity> getProductById(int id);

  /// Obtiene todas las categorías disponibles
  Future<List<String>> getCategories();

  /// Obtiene productos de una categoría específica
  Future<List<ProductEntity>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  });
}
