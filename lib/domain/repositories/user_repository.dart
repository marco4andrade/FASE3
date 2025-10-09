import '../models/user_model.dart';
import '../models/create_user_input.dart';

/// Contrato/Interface para el repositorio de usuarios
abstract class UserRepository {
  /// Obtiene todos los usuarios
  Future<List<UserModel>> getAllUsers({int? limit, String? sort});

  /// Obtiene un usuario por su ID
  Future<UserModel> getUserById(int id);

  /// Crea un nuevo usuario y retorna el modelo con ID asignado.
  Future<UserModel> createUser(CreateUserInput input);

  /// Autentica un usuario y retorna el token JWT emitido.
  Future<String> login(String username, String password);
}
