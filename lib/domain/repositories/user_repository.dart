import '../models/user_model.dart';

/// Contrato/Interface para el repositorio de usuarios
abstract class UserRepository {
  /// Obtiene todos los usuarios
  Future<List<UserModel>> getAllUsers({int? limit, String? sort});

  /// Obtiene un usuario por su ID
  Future<UserModel> getUserById(int id);
}
