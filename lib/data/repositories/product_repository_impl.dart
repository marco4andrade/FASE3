import 'package:dartz/dartz.dart';
import '../../domain/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/failures/failures.dart';
import '../datasources/fake_store_remote_datasource.dart';

/// Implementación concreta del repositorio de productos
/// Conecta el dominio con los datos externos
class ProductRepositoryImpl implements ProductRepository {
  final FakeStoreRemoteDataSource _ds;
  ProductRepositoryImpl({FakeStoreRemoteDataSource? dataSource}) : _ds = dataSource ?? FakeStoreRemoteDataSource();

  FakeStoreRemoteDataSource get dataSource => _ds; // permite acceder a dispose si se creó internamente

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts({int? limit, String? sort}) async {
    return _ds.getAllProducts(limit: limit, sort: sort);
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(int id) async {
    return _ds.getProductById(id);
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    return _ds.getCategories();
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  }) async {
    return _ds.getProductsByCategory(
      category,
      limit: limit,
      sort: sort,
    );
  }
}
