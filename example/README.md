# FakeStore Fase3 Mandrade

Un paquete Flutter educativo y ligero para interactuar con la [Fake Store API](https://fakestoreapi.com/). Refactorizado a un estilo minimalista: DataSource + Repositorios + Modelos.

## ✨ Características

✅ **Clean Architecture** - Código mantenible y testeable  
✅ **API Clara** - DataSource + repositorios explícitos  
✅ **Completamente tipado** - Modelos de dominio seguros con null safety  
✅ **Manejo de errores** - Excepciones descriptivas  
✅ **Testing incluido** - Suite completa de pruebas unitarias  
✅ **Documentación completa** - Métodos y clases documentados  

## 🛍️ API Endpoints

| Categoría | Endpoints | Descripción |
|-----------|-----------|-------------|
| **Productos** | `getAllProducts()` | Lista completa de productos |
| | `getProduct(id)` | Detalles de producto específico |
| | `getCategories()` | Todas las categorías |
| | `getProductsInCategory()` | Productos por categoría |
| **Usuarios** | `getAllUsers()` | Lista completa de usuarios |
| | `getUser(id)` | Detalles de usuario específico |
| **Carritos** | `getAllCarts()` | Lista completa de carritos |
| | `getCart(id)` | Detalles de carrito específico |
| | `getUserCarts(userId)` | Carritos de un usuario |

## 📦 Instalación

```yaml
dependencies:
  fakestore_fase3_mandrade: ^2.0.0
```

## 🚀 Uso Rápido (Nuevo Punto de Entrada)

```dart
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

// 1. Data source (maneja HTTP y parsing)
final ds = FakeStoreRemoteDataSource();

// 2. Repos que necesites (inyectando el datasource)
final productsRepo = ProductRepositoryImpl(dataSource: ds);
final usersRepo = UserRepositoryImpl(dataSource: ds);
final cartsRepo = CartRepositoryImpl(dataSource: ds);

// 3. Operaciones
final products = await productsRepo.getAllProducts(limit: 5);
final user = await usersRepo.getUserById(1);
final carts = await cartsRepo.getAllCarts();

print(products.first.title);
print(user.name.fullName);
print(carts.length);

```

## 📊 Ejemplos Detallados

### 🛍️ Productos

```dart
final ds = FakeStoreRemoteDataSource();
final productsRepo = ProductRepositoryImpl(dataSource: ds);

final products = await productsRepo.getAllProducts(limit: 10, sort: 'desc');
final categories = await productsRepo.getCategories();
final electronics = await productsRepo.getProductsByCategory('electronics');
final product = await productsRepo.getProductById(1);

print('${product.title} - \$${product.price}');
print('Rating: ${product.rating.rate}/5 (${product.rating.count} reviews)');

```

### 👥 Usuarios

```dart
final ds = FakeStoreRemoteDataSource();
final usersRepo = UserRepositoryImpl(dataSource: ds);

final users = await usersRepo.getAllUsers(limit: 5);
final user = await usersRepo.getUserById(1);
print('${user.name.firstName} ${user.name.lastName}');
print('Email: ${user.email}');
print('Ciudad: ${user.address.city}');
```

### 🛒 Carritos

```dart
final ds = FakeStoreRemoteDataSource();
final cartsRepo = CartRepositoryImpl(dataSource: ds);

final carts = await cartsRepo.getAllCarts();
final cart = await cartsRepo.getCartById(1);
final userCarts = await cartsRepo.getCartsByUserId(1);

print('Carrito del usuario: ${cart.userId}');
print('Total productos: ${cart.totalProducts}');
for (final p in cart.products) {
  print('Producto ${p.productId}: ${p.quantity} unidades');
}

```

## 🏛️ Arquitectura

Arquitectura minimalista orientada a transparencia:

- **Domain**: Modelos puros + mappers (`fromMap`)
- **Data**: `FakeStoreRemoteDataSource` (HTTP + parsing) + repositorios (`*RepositoryImpl`)

Racionales del cambio:
1. Menos capas -> menos fricción educativa.
2. Repos mantienen pequeña ergonomía (fechas en carritos) sin ocultar infraestructura.
3. Cualquier usuario puede crear su propio "client" si quiere una fachada.

Snippet opcional de client:
```dart
class FakeStoreClient {
  final FakeStoreRemoteDataSource ds = FakeStoreRemoteDataSource();
  late final ProductRepositoryImpl products = ProductRepositoryImpl(dataSource: ds);
  late final UserRepositoryImpl users = UserRepositoryImpl(dataSource: ds);
  late final CartRepositoryImpl carts = CartRepositoryImpl(dataSource: ds);
}
```

## 📱 Aplicación de Ejemplo

Incluye una aplicación completa en `example/` que demuestra todos los métodos del paquete con UI moderna y manejo de estados.

```bash
cd example
flutter pub get
flutter run
```

## 📚 Documentación

- [Documentación API](https://fakestoreapi.com/docs)
- [Changelog](CHANGELOG.md)
- [Licencia](LICENSE)

---

**Creado por Marco Andrade** - [GitHub](https://github.com/marco4andrade/FASE3)