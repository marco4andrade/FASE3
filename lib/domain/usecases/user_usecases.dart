import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Caso de uso para obtener todos los usuarios
class GetAllUsers {
  final UserRepository repository;

  GetAllUsers(this.repository);

  Future<List<UserEntity>> call({int? limit, String? sort}) {
    return repository.getAllUsers(limit: limit, sort: sort);
  }
}

/// Caso de uso para obtener un usuario específico
class GetUserById {
  final UserRepository repository;

  GetUserById(this.repository);

  Future<UserEntity> call(int id) {
    return repository.getUserById(id);
  }
}

/// Caso de uso para login
class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<String> call(String username, String password) {
    return repository.login(username, password);
  }
}
