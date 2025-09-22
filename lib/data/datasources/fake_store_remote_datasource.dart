import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_dto.dart';
import '../models/user_dto.dart';
import '../models/cart_dto.dart';

/// DataSource remoto para la Fake Store API
/// Responsable SOLO de hacer las llamadas HTTP y convertir JSON
class FakeStoreRemoteDataSource {
  static const String _baseUrl = 'https://fakestoreapi.com';
  final http.Client _httpClient;

  FakeStoreRemoteDataSource({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  void dispose() {
    _httpClient.close();
  }

  // ===== PRODUCTOS =====

  Future<List<ProductDto>> getAllProducts({int? limit, String? sort}) async {
    var url = '$_baseUrl/products';
    final queryParams = <String, String>{};

    if (limit != null) queryParams['limit'] = limit.toString();
    if (sort != null) queryParams['sort'] = sort;

    if (queryParams.isNotEmpty) {
      url += '?${Uri(queryParameters: queryParams).query}';
    }

    final response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductDto.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener productos: ${response.statusCode}');
    }
  }

  Future<ProductDto> getProductById(int id) async {
    final response = await _httpClient.get(Uri.parse('$_baseUrl/products/$id'));

    if (response.statusCode == 200) {
      return ProductDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener producto $id: ${response.statusCode}');
    }
  }

  Future<List<String>> getCategories() async {
    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/products/categories'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.cast<String>();
    } else {
      throw Exception('Error al obtener categorías: ${response.statusCode}');
    }
  }

  Future<List<ProductDto>> getProductsByCategory(
    String category, {
    int? limit,
    String? sort,
  }) async {
    var url = '$_baseUrl/products/category/$category';
    final queryParams = <String, String>{};

    if (limit != null) queryParams['limit'] = limit.toString();
    if (sort != null) queryParams['sort'] = sort;

    if (queryParams.isNotEmpty) {
      url += '?${Uri(queryParameters: queryParams).query}';
    }

    final response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductDto.fromJson(json)).toList();
    } else {
      throw Exception(
        'Error al obtener productos de categoría $category: ${response.statusCode}',
      );
    }
  }

  // ===== USUARIOS =====

  Future<List<UserDto>> getAllUsers({int? limit, String? sort}) async {
    var url = '$_baseUrl/users';
    final queryParams = <String, String>{};

    if (limit != null) queryParams['limit'] = limit.toString();
    if (sort != null) queryParams['sort'] = sort;

    if (queryParams.isNotEmpty) {
      url += '?${Uri(queryParameters: queryParams).query}';
    }

    final response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => UserDto.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener usuarios: ${response.statusCode}');
    }
  }

  Future<UserDto> getUserById(int id) async {
    final response = await _httpClient.get(Uri.parse('$_baseUrl/users/$id'));

    if (response.statusCode == 200) {
      return UserDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener usuario $id: ${response.statusCode}');
    }
  }

  // ===== CARRITOS =====

  Future<List<CartDto>> getAllCarts({
    int? limit,
    String? sort,
    String? startDate,
    String? endDate,
  }) async {
    var url = '$_baseUrl/carts';
    final queryParams = <String, String>{};

    if (limit != null) queryParams['limit'] = limit.toString();
    if (sort != null) queryParams['sort'] = sort;
    if (startDate != null) queryParams['startdate'] = startDate;
    if (endDate != null) queryParams['enddate'] = endDate;

    if (queryParams.isNotEmpty) {
      url += '?${Uri(queryParameters: queryParams).query}';
    }

    final response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CartDto.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener carritos: ${response.statusCode}');
    }
  }

  Future<CartDto> getCartById(int id) async {
    final response = await _httpClient.get(Uri.parse('$_baseUrl/carts/$id'));

    if (response.statusCode == 200) {
      return CartDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener carrito $id: ${response.statusCode}');
    }
  }

  Future<List<CartDto>> getCartsByUserId(int userId) async {
    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/carts/user/$userId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CartDto.fromJson(json)).toList();
    } else {
      throw Exception(
        'Error al obtener carritos del usuario $userId: ${response.statusCode}',
      );
    }
  }
}
