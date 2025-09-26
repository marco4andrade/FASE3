import '../../domain/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/fake_store_remote_datasource.dart';

/// Implementación concreta del repositorio de usuarios
class UserRepositoryImpl implements UserRepository {
  final FakeStoreRemoteDataSource _ds;
  UserRepositoryImpl({FakeStoreRemoteDataSource? dataSource}) : _ds = dataSource ?? FakeStoreRemoteDataSource();

  FakeStoreRemoteDataSource get dataSource => _ds;

  @override
  Future<List<UserModel>> getAllUsers({int? limit, String? sort}) async {
    return _ds.getAllUsers(limit: limit, sort: sort);
  }

  @override
  Future<UserModel> getUserById(int id) async {
    return _ds.getUserById(id);
  }
}
