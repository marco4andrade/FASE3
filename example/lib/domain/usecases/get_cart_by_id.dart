import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetCartById {
  final CartRepository _repo;
  const GetCartById(this._repo);

  Future<CartModel> call(int id) => _repo.getCartById(id);
}
