import 'package:dartz/dartz.dart';
import '../../domain/models/user_model.dart';
import '../../domain/models/create_user_input.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/failures/failures.dart';
import '../datasources/fake_store_remote_datasource.dart';

/// Implementación concreta del repositorio de usuarios
class UserRepositoryImpl implements UserRepository {
  final FakeStoreRemoteDataSource _ds;
  UserRepositoryImpl({FakeStoreRemoteDataSource? dataSource}) : _ds = dataSource ?? FakeStoreRemoteDataSource();

  FakeStoreRemoteDataSource get dataSource => _ds;

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers({int? limit, String? sort}) async {
    return _ds.getAllUsers(limit: limit, sort: sort);
  }

  @override
  Future<Either<Failure, UserModel>> getUserById(int id) async {
    return _ds.getUserById(id);
  }

  @override
  Future<Either<Failure, UserModel>> createUser(CreateUserInput input) async {
    return _ds.createUser(input);
  }

  @override
  Future<Either<Failure, String>> login(String username, String password) async {
    return _ds.login(username: username, password: password);
  }
}
