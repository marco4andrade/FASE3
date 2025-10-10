import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/product_model.dart';
import '../../domain/models/user_model.dart';
import '../../domain/models/cart_model.dart';
import '../../domain/mappers/product_mappers.dart';
import '../../domain/mappers/user_mappers.dart';
import '../../domain/mappers/cart_mappers.dart';
import '../../domain/models/create_user_input.dart';
import '../../domain/failures/failures.dart';

/// DataSource remoto para la Fake Store API.
/// Encapsula peticiones HTTP y mapping JSON -> Modelos.
class FakeStoreRemoteDataSource {
  static const String _baseUrl = 'https://fakestoreapi.com';
  final http.Client _client;

  FakeStoreRemoteDataSource({http.Client? httpClient}) : _client = httpClient ?? http.Client();

  // ===== PRODUCTOS =====
  Future<Either<Failure, List<ProductModel>>> getAllProducts({int? limit, String? sort}) async {
    try {
      var url = '$_baseUrl/products';
      final qp = <String, String>{};
      if (limit != null) qp['limit'] = '$limit';
      if (sort != null) qp['sort'] = sort;
      if (qp.isNotEmpty) url += '?${Uri(queryParameters: qp).query}';

      final resp = await _client.get(Uri.parse(url));
      if (resp.statusCode != 200) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al obtener productos',
        ));
      }
      final List<dynamic> data = json.decode(resp.body);
      final products = data.map((j) => ProductMapper.fromMap(j)).toList();
      return Right(products);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, ProductModel>> getProductById(int id) async {
    try {
      final resp = await _client.get(Uri.parse('$_baseUrl/products/$id'));
      if (resp.statusCode == 404) {
        return const Left(NotFoundFailure('Producto no encontrado'));
      }
      if (resp.statusCode != 200) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al obtener producto',
        ));
      }
      final product = ProductMapper.fromMap(json.decode(resp.body));
      return Right(product);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final resp = await _client.get(Uri.parse('$_baseUrl/products/categories'));
      if (resp.statusCode != 200) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al obtener categorías',
        ));
      }
      final List<dynamic> data = json.decode(resp.body);
      return Right(data.cast<String>());
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(String category, {int? limit, String? sort}) async {
    try {
      var url = '$_baseUrl/products/category/$category';
      final qp = <String, String>{};
      if (limit != null) qp['limit'] = '$limit';
      if (sort != null) qp['sort'] = sort;
      if (qp.isNotEmpty) url += '?${Uri(queryParameters: qp).query}';

      final resp = await _client.get(Uri.parse(url));
      if (resp.statusCode != 200) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al obtener productos de categoría $category',
        ));
      }
      final List<dynamic> data = json.decode(resp.body);
      final products = data.map((j) => ProductMapper.fromMap(j)).toList();
      return Right(products);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  // ===== USUARIOS =====
  Future<Either<Failure, List<UserModel>>> getAllUsers({int? limit, String? sort}) async {
    try {
      var url = '$_baseUrl/users';
      final qp = <String, String>{};
      if (limit != null) qp['limit'] = '$limit';
      if (sort != null) qp['sort'] = sort;
      if (qp.isNotEmpty) url += '?${Uri(queryParameters: qp).query}';

      final resp = await _client.get(Uri.parse(url));
      if (resp.statusCode != 200) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al obtener usuarios',
        ));
      }
      final List<dynamic> data = json.decode(resp.body);
      final users = data.map((j) => UserMapper.fromMap(j)).toList();
      return Right(users);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, UserModel>> getUserById(int id) async {
    try {
      final resp = await _client.get(Uri.parse('$_baseUrl/users/$id'));
      if (resp.statusCode == 404) {
        return const Left(NotFoundFailure('Usuario no encontrado'));
      }
      if (resp.statusCode != 200) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al obtener usuario',
        ));
      }
      final user = UserMapper.fromMap(json.decode(resp.body));
      return Right(user);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  /// Crea un nuevo usuario.
  /// Retorna el [UserModel] con el id asignado por la API.
  Future<Either<Failure, UserModel>> createUser(CreateUserInput input) async {
    try {
      final resp = await _client.post(
        Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(input.toJson()),
      );
      if (resp.statusCode != 200 && resp.statusCode != 201) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al crear usuario',
        ));
      }
      final user = UserMapper.fromMap(json.decode(resp.body));
      return Right(user);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  /// Autentica un usuario existente y retorna el token JWT devuelto por la API.
  Future<Either<Failure, String>> login({required String username, required String password}) async {
    try {
      final resp = await _client.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      // La API debería retornar 200, pero toleramos 201 (casos atípicos de algunos proxies/ambientes)
      if (resp.statusCode == 401 || resp.statusCode == 403) {
        return const Left(AuthenticationFailure('Credenciales inválidas'));
      }
      if (resp.statusCode != 200 && resp.statusCode != 201) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error de autenticación',
        ));
      }
      final data = json.decode(resp.body);
      final token = data['token'];
      if (token is! String || token.isEmpty) {
        return const Left(ParsingFailure('Token inválido en respuesta de login'));
      }
      return Right(token);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  // ===== CARRITOS =====
  Future<Either<Failure, List<CartModel>>> getAllCarts({int? limit, String? sort, String? startDate, String? endDate}) async {
    try {
      var url = '$_baseUrl/carts';
      final qp = <String, String>{};
      if (limit != null) qp['limit'] = '$limit';
      if (sort != null) qp['sort'] = sort;
      if (startDate != null) qp['startdate'] = startDate;
      if (endDate != null) qp['enddate'] = endDate;
      if (qp.isNotEmpty) url += '?${Uri(queryParameters: qp).query}';

      final resp = await _client.get(Uri.parse(url));
      if (resp.statusCode != 200) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al obtener carritos',
        ));
      }
      final List<dynamic> data = json.decode(resp.body);
      final carts = data.map((j) => CartMapper.fromMap(j)).toList();
      return Right(carts);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, CartModel>> getCartById(int id) async {
    try {
      final resp = await _client.get(Uri.parse('$_baseUrl/carts/$id'));
      if (resp.statusCode == 404) {
        return const Left(NotFoundFailure('Carrito no encontrado'));
      }
      if (resp.statusCode != 200) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al obtener carrito',
        ));
      }
      final cart = CartMapper.fromMap(json.decode(resp.body));
      return Right(cart);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, List<CartModel>>> getCartsByUserId(int userId) async {
    try {
      final resp = await _client.get(Uri.parse('$_baseUrl/carts/user/$userId'));
      if (resp.statusCode != 200) {
        return Left(ServerFailure(
          statusCode: resp.statusCode,
          message: 'Error al obtener carritos del usuario $userId',
        ));
      }
      final List<dynamic> data = json.decode(resp.body);
      final carts = data.map((j) => CartMapper.fromMap(j)).toList();
      return Right(carts);
    } on SocketException {
      return const Left(NetworkFailure());
    } on FormatException {
      return const Left(ParsingFailure());
    } catch (e) {
      return Left(UnknownFailure('Error inesperado: $e'));
    }
  }
}
