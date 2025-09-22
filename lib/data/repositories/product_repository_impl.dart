import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/fake_store_remote_datasource.dart';

/// Implementación concreta del repositorio de productos
/// Conecta el dominio con los datos externos
class ProductRepositoryImpl implements ProductRepository {
  final FakeStoreRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ProductEntity>> getAllProducts({int? limit, String? sort}) async {
    final productDtos = await _remoteDataSource.getAllProducts(
      limit: limit,
      sort: sort,
    );
    // Mapear DTOs a Entidades
    return productDtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<ProductEntity> getProductById(int id) async {
    final productDto = await _remoteDataSource.getProductById(id);
    return productDto.toEntity();
  }

  @override
  Future<List<String>> getCategories() async {
    return _remoteDataSource.getCategories();
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  }) async {
    final productDtos = await _remoteDataSource.getProductsByCategory(
      category,
      limit: limit,
      sort: sort,
    );
    return productDtos.map((dto) => dto.toEntity()).toList();
  }
}
