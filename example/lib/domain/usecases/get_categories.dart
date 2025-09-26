import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

class GetCategories {
  final ProductRepository _repo;
  const GetCategories(this._repo);

  Future<List<String>> call() => _repo.getCategories();
}
