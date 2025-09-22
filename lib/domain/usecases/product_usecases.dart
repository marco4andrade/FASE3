import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// Caso de uso para obtener todos los productos
class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<List<ProductEntity>> call({int? limit, String? sort}) {
    return repository.getAllProducts(limit: limit, sort: sort);
  }
}

/// Caso de uso para obtener un producto específico
class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<ProductEntity> call(int id) {
    return repository.getProductById(id);
  }
}

/// Caso de uso para obtener categorías
class GetCategories {
  final ProductRepository repository;

  GetCategories(this.repository);

  Future<List<String>> call() {
    return repository.getCategories();
  }
}

/// Caso de uso para obtener productos por categoría
class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<List<ProductEntity>> call(
    String category, {
    int? limit,
    String? sort,
  }) {
    return repository.getProductsByCategory(category, limit: limit, sort: sort);
  }
}
