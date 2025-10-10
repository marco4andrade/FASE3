import 'package:dartz/dartz.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class LoginUser {
  final UserRepository _repo;
  const LoginUser(this._repo);

  Future<Either<Failure, String>> call({required String username, required String password}) => _repo.login(username, password);
}
