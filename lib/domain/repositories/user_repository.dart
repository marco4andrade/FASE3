import '../entities/user_entity.dart';

/// Contrato/Interface para el repositorio de usuarios
abstract class UserRepository {
  /// Obtiene todos los usuarios
  Future<List<UserEntity>> getAllUsers({int? limit, String? sort});

  /// Obtiene un usuario por su ID
  Future<UserEntity> getUserById(int id);
}
