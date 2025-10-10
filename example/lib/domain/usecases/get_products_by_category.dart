import 'package:dartz/dartz.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetProductsByCategory {
  final ProductRepository _repo;
  const GetProductsByCategory(this._repo);

  Future<Either<Failure, List<ProductModel>>> call(String category, {int? limit, String? sort}) {
    return _repo.getProductsByCategory(category, limit: limit, sort: sort);
  }
}
