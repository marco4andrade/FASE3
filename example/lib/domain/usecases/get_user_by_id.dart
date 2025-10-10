import 'package:dartz/dartz.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetUserById {
  final UserRepository _repo;
  const GetUserById(this._repo);

  Future<Either<Failure, UserModel>> call(int id) => _repo.getUserById(id);
}
