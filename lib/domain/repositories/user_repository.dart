import 'package:dartz/dartz.dart';
import '../models/user_model.dart';
import '../models/create_user_input.dart';
import '../failures/failures.dart';

/// Contrato/Interface para el repositorio de usuarios
abstract class UserRepository {
  /// Obtiene todos los usuarios
  Future<Either<Failure, List<UserModel>>> getAllUsers({int? limit, String? sort});

  /// Obtiene un usuario por su ID
  Future<Either<Failure, UserModel>> getUserById(int id);

  /// Crea un nuevo usuario y retorna el modelo con ID asignado.
  Future<Either<Failure, UserModel>> createUser(CreateUserInput input);

  /// Autentica un usuario y retorna el token JWT emitido.
  Future<Either<Failure, String>> login(String username, String password);
}
