import 'package:dartz/dartz.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetAllCarts {
  final CartRepository _repo;
  const GetAllCarts(this._repo);

  Future<Either<Failure, List<CartModel>>> call({int? limit, String? sort}) => _repo.getAllCarts(limit: limit, sort: sort);
}
