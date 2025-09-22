import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/fake_store_remote_datasource.dart';

/// Implementación concreta del repositorio de usuarios
class UserRepositoryImpl implements UserRepository {
  final FakeStoreRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<UserEntity>> getAllUsers({int? limit, String? sort}) async {
    final userDtos = await _remoteDataSource.getAllUsers(
      limit: limit,
      sort: sort,
    );
    return userDtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<UserEntity> getUserById(int id) async {
    final userDto = await _remoteDataSource.getUserById(id);
    return userDto.toEntity();
  }

  @override
  Future<String> login(String username, String password) async {
    return _remoteDataSource.login(username, password);
  }
}
