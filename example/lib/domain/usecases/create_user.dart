import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class CreateUser {
  final UserRepository _repo;
  const CreateUser(this._repo);

  Future<UserModel> call(CreateUserInput input) => _repo.createUser(input);
}
