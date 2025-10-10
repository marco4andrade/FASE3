import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

void main() {
  group('Clean Architecture - Repos + DataSource con Either', () {
    late ProductRepositoryImpl productRepo;
    late UserRepositoryImpl userRepo;
    late CartRepositoryImpl cartRepo;

    setUp(() {
      // Se configurará un mock client en cada test específico
    });

    test('getAllProducts debe retornar Right con lista de productos', () async {
      final mockClient = MockClient((request) async {
        final products = [
          {
            'id': 1,
            'title': 'Test Product 1',
            'price': 29.99,
            'description': 'Test description 1',
            'category': 'test category',
            'image': 'https://test.com/image1.jpg',
            'rating': {'rate': 4.5, 'count': 10},
          },
          {
            'id': 2,
            'title': 'Test Product 2',
            'price': 39.99,
            'description': 'Test description 2',
            'category': 'test category',
            'image': 'https://test.com/image2.jpg',
            'rating': {'rate': 4.0, 'count': 5},
          },
        ];
        return http.Response(json.encode(products), 200);
      });

      productRepo = ProductRepositoryImpl(dataSource: FakeStoreRemoteDataSource(httpClient: mockClient));

      final result = await productRepo.getAllProducts();

      expect(result, isA<Right<Failure, List<ProductModel>>>());
      result.fold(
        (failure) => fail('Should return Right, but got Left: $failure'),
        (products) {
          expect(products.length, 2);
          expect(products[0], isA<ProductModel>());
          expect(products[0].title, 'Test Product 1');
          expect(products[1].title, 'Test Product 2');
        },
      );
    });

    test('getProduct debe retornar Right con producto específico', () async {
        final mockClient = MockClient((request) async {
          final product = {
            'id': 1,
            'title': 'Test Product',
            'price': 29.99,
            'description': 'Test description',
            'category': 'test category',
            'image': 'https://test.com/image.jpg',
            'rating': {'rate': 4.5, 'count': 10},
          };
          return http.Response(json.encode(product), 200);
        });

        productRepo = ProductRepositoryImpl(dataSource: FakeStoreRemoteDataSource(httpClient: mockClient));
        final result = await productRepo.getProductById(1);

        expect(result, isA<Right<Failure, ProductModel>>());
        result.fold(
          (failure) => fail('Should return Right, but got Left: $failure'),
          (product) {
            expect(product.id, 1);
            expect(product.title, 'Test Product');
          },
        );
      },
    );

    test('getAllUsers debe retornar Right con lista de usuarios', () async {
      final mockClient = MockClient((request) async {
        final users = [
          {
            'id': 1,
            'email': 'test@example.com',
            'username': 'testuser',
            'password': 'password',
            'name': {'firstname': 'John', 'lastname': 'Doe'},
            'address': {
              'city': 'Test City',
              'street': 'Test Street',
              'number': 123,
              'zipcode': '12345',
              'geolocation': {'lat': '40.7128', 'long': '-74.0060'},
            },
            'phone': '123-456-7890',
          },
        ];
        return http.Response(json.encode(users), 200);
      });

      userRepo = UserRepositoryImpl(dataSource: FakeStoreRemoteDataSource(httpClient: mockClient));
      final result = await userRepo.getAllUsers();

      expect(result, isA<Right<Failure, List<UserModel>>>());
      result.fold(
        (failure) => fail('Should return Right, but got Left: $failure'),
        (users) {
          expect(users.length, 1);
          expect(users[0], isA<UserModel>());
          expect(users[0].name.fullName, 'John Doe');
          expect(users[0].email, 'test@example.com');
        },
      );
    });

    test('createUser debe retornar Right con usuario creado', () async {
      final mockClient = MockClient((request) async {
        if (request.method == 'POST' && request.url.path == '/users') {
          final body = json.decode(request.body);
          // Simulamos retorno con id
          body['id'] = 50;
          return http.Response(json.encode(body), 200);
        }
        return http.Response('Not Found', 404);
      });

      userRepo = UserRepositoryImpl(dataSource: FakeStoreRemoteDataSource(httpClient: mockClient));

      const input = CreateUserInput(
        email: 'new@example.com',
        username: 'newuser',
        password: 'Secret123',
        firstName: 'New',
        lastName: 'User',
        city: 'City',
        street: 'Street',
        number: 1,
        zipCode: '00000',
        geoLat: '0',
        geoLong: '0',
        phone: '000-000',
      );

      final result = await userRepo.createUser(input);
      
      expect(result, isA<Right<Failure, UserModel>>());
      result.fold(
        (failure) => fail('Should return Right, but got Left: $failure'),
        (created) {
          expect(created.id, 50);
          expect(created.username, 'newuser');
        },
      );
    });

    test('login debe retornar Right con token', () async {
      final mockClient = MockClient((request) async {
        if (request.method == 'POST' && request.url.path == '/auth/login') {
          return http.Response(json.encode({'token': 'abc.def.ghi'}), 200);
        }
        return http.Response('Not Found', 404);
      });

      userRepo = UserRepositoryImpl(dataSource: FakeStoreRemoteDataSource(httpClient: mockClient));
      final result = await userRepo.login('user', 'pass');
      
      expect(result, isA<Right<Failure, String>>());
      result.fold(
        (failure) => fail('Should return Right, but got Left: $failure'),
        (token) => expect(token, 'abc.def.ghi'),
      );
    });

    test('login debe aceptar status 201 y retornar Right con token', () async {
      final mockClient = MockClient((request) async {
        if (request.method == 'POST' && request.url.path == '/auth/login') {
          return http.Response(json.encode({'token': 'zzz.yyy.xxx'}), 201);
        }
        return http.Response('Not Found', 404);
      });

      userRepo = UserRepositoryImpl(dataSource: FakeStoreRemoteDataSource(httpClient: mockClient));
      final result = await userRepo.login('user', 'pass');
      
      expect(result, isA<Right<Failure, String>>());
      result.fold(
        (failure) => fail('Should return Right, but got Left: $failure'),
        (token) => expect(token, 'zzz.yyy.xxx'),
      );
    });

    test('getAllCarts debe retornar Right con lista de carritos', () async {
      final mockClient = MockClient((request) async {
        final carts = [
          {
            'id': 1,
            'userId': 1,
            'date': '2024-01-01',
            'products': [
              {'productId': 1, 'quantity': 2},
              {'productId': 2, 'quantity': 1},
            ],
          },
        ];
        return http.Response(json.encode(carts), 200);
      });

      cartRepo = CartRepositoryImpl(dataSource: FakeStoreRemoteDataSource(httpClient: mockClient));
      final result = await cartRepo.getAllCarts();

      expect(result, isA<Right<Failure, List<CartModel>>>());
      result.fold(
        (failure) => fail('Should return Right, but got Left: $failure'),
        (carts) {
          expect(carts.length, 1);
          expect(carts[0], isA<CartModel>());
          expect(carts[0].products.length, 2);
          expect(carts[0].totalProducts, 3);
        },
      );
    });

    test('debe retornar Left cuando la API retorna error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      productRepo = ProductRepositoryImpl(dataSource: FakeStoreRemoteDataSource(httpClient: mockClient));

      final result = await productRepo.getProductById(999);
      
      expect(result, isA<Left<Failure, ProductModel>>());
      result.fold(
        (failure) {
          expect(failure, isA<NotFoundFailure>());
          expect(failure.message, 'Producto no encontrado');
        },
        (product) => fail('Should return Left, but got Right: $product'),
      );
    });

    test('debe retornar Left con ServerFailure para errores HTTP 500', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });

      productRepo = ProductRepositoryImpl(dataSource: FakeStoreRemoteDataSource(httpClient: mockClient));

      final result = await productRepo.getAllProducts();
      
      expect(result, isA<Left<Failure, List<ProductModel>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect((failure as ServerFailure).statusCode, 500);
        },
        (products) => fail('Should return Left, but got Right: $products'),
      );
    });

    tearDown(() {
      // Limpiar después de cada test si es necesario
    });
  });

  group('Modelos del Dominio', () {
    test('ProductModel debe funcionar correctamente', () {
      const rating = RatingModel(rate: 4.5, count: 10);
      const product = ProductModel(
        id: 1,
        title: 'Test Product',
        price: 29.99,
        description: 'Test description',
        category: 'test category',
        imageUrl: 'https://test.com/image.jpg',
        rating: rating,
      );

      expect(product.id, 1);
      expect(product.title, 'Test Product');
      expect(product.price, 29.99);
      expect(product.rating.rate, 4.5);
    });

    test('UserModel debe funcionar correctamente', () {
      const name = NameModel(firstName: 'John', lastName: 'Doe');
      const geo = GeolocationModel(latitude: 40.7128, longitude: -74.0060);
      const address = AddressModel(
        city: 'Test City',
        street: 'Test Street',
        number: 123,
        zipCode: '12345',
        geolocation: geo,
      );
      const user = UserModel(
        id: 1,
        email: 'test@example.com',
        username: 'testuser',
        name: name,
        address: address,
        phone: '123-456-7890',
      );

      expect(user.id, 1);
      expect(user.name.fullName, 'John Doe');
      expect(user.email, 'test@example.com');
    });

    test('CartModel debe calcular total correctamente', () {
      const products = [
        CartProductModel(productId: 1, quantity: 2),
        CartProductModel(productId: 2, quantity: 3),
      ];
      final cart = CartModel(
        id: 1,
        userId: 1,
        date: DateTime.now(),
        products: products,
      );

      expect(cart.totalProducts, 5);
      expect(cart.products.length, 2);
    });
  });
}
