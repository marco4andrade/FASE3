import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetUserById {
  final UserRepository _repo;
  const GetUserById(this._repo);

  Future<UserModel> call(int id) => _repo.getUserById(id);
}
