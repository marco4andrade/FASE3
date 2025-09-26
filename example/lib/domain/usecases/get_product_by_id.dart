import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetProductById {
  final ProductRepository _repo;
  const GetProductById(this._repo);

  Future<ProductModel> call(int id) => _repo.getProductById(id);
}
