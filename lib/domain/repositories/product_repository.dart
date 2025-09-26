import '../models/product_model.dart';

/// Contrato/Interface para el repositorio de productos
/// Define QUÉ se puede hacer, no CÓMO se hace
abstract class ProductRepository {
  /// Obtiene todos los productos
  Future<List<ProductModel>> getAllProducts({int? limit, String? sort});

  /// Obtiene un producto por su ID
  Future<ProductModel> getProductById(int id);

  /// Obtiene todas las categorías disponibles
  Future<List<String>> getCategories();

  /// Obtiene productos de una categoría específica
  Future<List<ProductModel>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  });
}
