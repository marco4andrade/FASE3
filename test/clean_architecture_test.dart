import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

void main() {
  group('Clean Architecture - FakeStoreService', () {
    late FakeStoreService service;

    setUp(() {
      // Se configurará un mock client en cada test específico
    });

    test('getAllProducts debe retornar entidades de productos', () async {
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

      service = FakeStoreService(httpClient: mockClient);
      final products = await service.getAllProducts();

      expect(products.length, 2);
      expect(products[0], isA<ProductEntity>());
      expect(products[0].title, 'Test Product 1');
      expect(products[1].title, 'Test Product 2');

      service.dispose();
    });

    test(
      'getProduct debe retornar una entidad de producto específica',
      () async {
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

        service = FakeStoreService(httpClient: mockClient);
        final product = await service.getProduct(1);

        expect(product, isA<ProductEntity>());
        expect(product.id, 1);
        expect(product.title, 'Test Product');

        service.dispose();
      },
    );

    test('getAllUsers debe retornar entidades de usuarios', () async {
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

      service = FakeStoreService(httpClient: mockClient);
      final users = await service.getAllUsers();

      expect(users.length, 1);
      expect(users[0], isA<UserEntity>());
      expect(users[0].name.fullName, 'John Doe');
      expect(users[0].email, 'test@example.com');

      service.dispose();
    });

    test('getAllCarts debe retornar entidades de carritos', () async {
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

      service = FakeStoreService(httpClient: mockClient);
      final carts = await service.getAllCarts();

      expect(carts.length, 1);
      expect(carts[0], isA<CartEntity>());
      expect(carts[0].products.length, 2);
      expect(carts[0].totalProducts, 3);

      service.dispose();
    });

    test('debe lanzar excepción cuando la API retorna error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      service = FakeStoreService(httpClient: mockClient);

      expect(() async => await service.getProduct(999), throwsException);

      service.dispose();
    });

    tearDown(() {
      // Limpiar después de cada test si es necesario
    });
  });

  group('Entidades del Dominio', () {
    test('ProductEntity debe funcionar correctamente', () {
      const rating = RatingEntity(rate: 4.5, count: 10);
      const product = ProductEntity(
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

    test('UserEntity debe funcionar correctamente', () {
      const name = NameEntity(firstName: 'John', lastName: 'Doe');
      const geo = GeolocationEntity(latitude: 40.7128, longitude: -74.0060);
      const address = AddressEntity(
        city: 'Test City',
        street: 'Test Street',
        number: 123,
        zipCode: '12345',
        geolocation: geo,
      );
      const user = UserEntity(
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

    test('CartEntity debe calcular total correctamente', () {
      const products = [
        CartProductEntity(productId: 1, quantity: 2),
        CartProductEntity(productId: 2, quantity: 3),
      ];
      final cart = CartEntity(
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
