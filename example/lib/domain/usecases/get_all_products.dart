import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetAllProducts {
  final ProductRepository _repo;
  const GetAllProducts(this._repo);

  Future<List<ProductModel>> call({int? limit, String? sort}) => _repo.getAllProducts(limit: limit, sort: sort);
}
