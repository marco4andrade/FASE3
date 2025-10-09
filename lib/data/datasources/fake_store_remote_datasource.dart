import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/product_model.dart';
import '../../domain/models/user_model.dart';
import '../../domain/models/cart_model.dart';
import '../../domain/mappers/product_mappers.dart';
import '../../domain/mappers/user_mappers.dart';
import '../../domain/mappers/cart_mappers.dart';
import '../../domain/models/create_user_input.dart';

/// DataSource remoto para la Fake Store API.
/// Encapsula peticiones HTTP y mapping JSON -> Modelos.
class FakeStoreRemoteDataSource {
  static const String _baseUrl = 'https://fakestoreapi.com';
  final http.Client _client;

  FakeStoreRemoteDataSource({http.Client? httpClient}) : _client = httpClient ?? http.Client();

  // ===== PRODUCTOS =====
  Future<List<ProductModel>> getAllProducts({int? limit, String? sort}) async {
    var url = '$_baseUrl/products';
    final qp = <String, String>{};
    if (limit != null) qp['limit'] = '$limit';
    if (sort != null) qp['sort'] = sort;
    if (qp.isNotEmpty) url += '?${Uri(queryParameters: qp).query}';

    final resp = await _client.get(Uri.parse(url));
    if (resp.statusCode != 200) {
      throw Exception('Error al obtener productos: ${resp.statusCode}');
    }
    final List<dynamic> data = json.decode(resp.body);
    return data.map((j) => ProductMapper.fromMap(j)).toList();
  }

  Future<ProductModel> getProductById(int id) async {
    final resp = await _client.get(Uri.parse('$_baseUrl/products/$id'));
    if (resp.statusCode != 200) {
      throw Exception('Error al obtener producto $id: ${resp.statusCode}');
    }
    return ProductMapper.fromMap(json.decode(resp.body));
  }

  Future<List<String>> getCategories() async {
    final resp = await _client.get(Uri.parse('$_baseUrl/products/categories'));
    if (resp.statusCode != 200) {
      throw Exception('Error al obtener categorías: ${resp.statusCode}');
    }
    final List<dynamic> data = json.decode(resp.body);
    return data.cast<String>();
  }

  Future<List<ProductModel>> getProductsByCategory(String category, {int? limit, String? sort}) async {
    var url = '$_baseUrl/products/category/$category';
    final qp = <String, String>{};
    if (limit != null) qp['limit'] = '$limit';
    if (sort != null) qp['sort'] = sort;
    if (qp.isNotEmpty) url += '?${Uri(queryParameters: qp).query}';

    final resp = await _client.get(Uri.parse(url));
    if (resp.statusCode != 200) {
      throw Exception('Error al obtener productos de categoría $category: ${resp.statusCode}');
    }
    final List<dynamic> data = json.decode(resp.body);
    return data.map((j) => ProductMapper.fromMap(j)).toList();
  }

  // ===== USUARIOS =====
  Future<List<UserModel>> getAllUsers({int? limit, String? sort}) async {
    var url = '$_baseUrl/users';
    final qp = <String, String>{};
    if (limit != null) qp['limit'] = '$limit';
    if (sort != null) qp['sort'] = sort;
    if (qp.isNotEmpty) url += '?${Uri(queryParameters: qp).query}';

    final resp = await _client.get(Uri.parse(url));
    if (resp.statusCode != 200) {
      throw Exception('Error al obtener usuarios: ${resp.statusCode}');
    }
    final List<dynamic> data = json.decode(resp.body);
    return data.map((j) => UserMapper.fromMap(j)).toList();
  }

  Future<UserModel> getUserById(int id) async {
    final resp = await _client.get(Uri.parse('$_baseUrl/users/$id'));
    if (resp.statusCode != 200) {
      throw Exception('Error al obtener usuario $id: ${resp.statusCode}');
    }
    return UserMapper.fromMap(json.decode(resp.body));
  }

  /// Crea un nuevo usuario.
  /// Retorna el [UserModel] con el id asignado por la API.
  Future<UserModel> createUser(CreateUserInput input) async {
    final resp = await _client.post(
      Uri.parse('$_baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(input.toJson()),
    );
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Error al crear usuario: ${resp.statusCode} ${resp.body}');
    }
    return UserMapper.fromMap(json.decode(resp.body));
  }

  /// Autentica un usuario existente y retorna el token JWT devuelto por la API.
  Future<String> login({required String username, required String password}) async {
    final resp = await _client.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    // La API debería retornar 200, pero toleramos 201 (casos atípicos de algunos proxies/ambientes)
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Error de autenticación: ${resp.statusCode} ${resp.body}');
    }
    final data = json.decode(resp.body);
    final token = data['token'];
    if (token is! String || token.isEmpty) {
      throw Exception('Token inválido en respuesta de login');
    }
    return token;
  }

  // ===== CARRITOS =====
  Future<List<CartModel>> getAllCarts({int? limit, String? sort, String? startDate, String? endDate}) async {
    var url = '$_baseUrl/carts';
    final qp = <String, String>{};
    if (limit != null) qp['limit'] = '$limit';
    if (sort != null) qp['sort'] = sort;
    if (startDate != null) qp['startdate'] = startDate;
    if (endDate != null) qp['enddate'] = endDate;
    if (qp.isNotEmpty) url += '?${Uri(queryParameters: qp).query}';

    final resp = await _client.get(Uri.parse(url));
    if (resp.statusCode != 200) {
      throw Exception('Error al obtener carritos: ${resp.statusCode}');
    }
    final List<dynamic> data = json.decode(resp.body);
    return data.map((j) => CartMapper.fromMap(j)).toList();
  }

  Future<CartModel> getCartById(int id) async {
    final resp = await _client.get(Uri.parse('$_baseUrl/carts/$id'));
    if (resp.statusCode != 200) {
      throw Exception('Error al obtener carrito $id: ${resp.statusCode}');
    }
    return CartMapper.fromMap(json.decode(resp.body));
  }

  Future<List<CartModel>> getCartsByUserId(int userId) async {
    final resp = await _client.get(Uri.parse('$_baseUrl/carts/user/$userId'));
    if (resp.statusCode != 200) {
      throw Exception('Error al obtener carritos del usuario $userId: ${resp.statusCode}');
    }
    final List<dynamic> data = json.decode(resp.body);
    return data.map((j) => CartMapper.fromMap(j)).toList();
  }
}
