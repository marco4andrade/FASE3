import 'package:dartz/dartz.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetCategories {
  final ProductRepository _repo;
  const GetCategories(this._repo);

  Future<Either<Failure, List<String>>> call() => _repo.getCategories();
}
