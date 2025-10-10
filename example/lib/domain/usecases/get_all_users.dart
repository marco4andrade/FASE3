import 'package:dartz/dartz.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetAllUsers {
  final UserRepository _repo;
  const GetAllUsers(this._repo);

  Future<Either<Failure, List<UserModel>>> call({int? limit, String? sort}) => _repo.getAllUsers(limit: limit, sort: sort);
}
