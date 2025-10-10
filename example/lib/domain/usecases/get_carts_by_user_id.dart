import 'package:dartz/dartz.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetCartsByUserId {
  final CartRepository _repo;
  const GetCartsByUserId(this._repo);

  Future<Either<Failure, List<CartModel>>> call(int userId) => _repo.getCartsByUserId(userId);
}
