# FakeStore Fase3 Mandrade

Un paquete Flutter educativo y ligero para interactuar con la [Fake Store API](https://fakestoreapi.com/). Refactorizado a un estilo minimalista: DataSource + Repositorios + Modelos (sin fachada).

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
| | `createUser(input)` | Crea nuevo usuario |
| | `login(username,password)` | Autentica y retorna token JWT |
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

// No se requiere dispose explícito.
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

// No se requiere dispose.
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
// No se requiere dispose.

// Crear nuevo usuario
final nuevo = await usersRepo.createUser(
  CreateUserInput.minimal(
    email: 'new@example.com',
    username: 'newuser',
    password: 'Secret123',
  ),
);
print('Usuario creado id=${nuevo.id}');

// Login (autenticación)
final token = await usersRepo.login('mor_2314', '83r5^_');
print('Token: $token');
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

La librería sigue un modelo deliberadamente minimalista para que entiendas rápido el flujo sin capas "ceremoniales".

Flujo de datos (request → modelo):
```
HTTP (Fake Store API)
   ↓
FakeStoreRemoteDataSource  (GET + decode JSON)
   ↓
*RepositoryImpl            (adaptaciones ligeras / consistencia)
   ↓
Tu código (UI, Controlador, UseCase propio, etc.)
```

### Capas incluidas
- Data Source (`FakeStoreRemoteDataSource`):
  - Realiza peticiones HTTP.
  - Decodifica JSON y delega a los mappers.
  - Inyectable con `http.Client` personalizado (para logging, retry, etc.).
- Repositorios (`ProductRepositoryImpl`, `UserRepositoryImpl`, `CartRepositoryImpl`):
  - Proveen una interfaz clara y estable.
  - Pueden ser decorados (caching, logging) sin tocar el data source.
- Modelos + Mappers: Estructuras inmutables con conversión segura desde el JSON de la API.

### Capas que NO se incluyen (y por qué)
| Capa        | Motivo de ausencia | Cuándo agregarla tú |
|-------------|--------------------|----------------------|
| Use Cases   | Los métodos del repo ya son atómicos y claros. | Si necesitas orquestar múltiples repos o aplicar reglas. |
| Facade/Service | Sería solo un pass-through adicional. | Si expones un SDK unificado interno para tu app. |
| Data Local Cache | Evita complejidad inicial. | Si tu app necesita offline o reducir llamadas. |

### Principios aplicados
- KISS / YAGNI: Solo lo necesario para consumir la API productivamente.
- SRP: DataSource (transport + parse) y Repos (contrato semántico) separados.
- Open/Closed: Puedes envolver repos o datasource con decorators sin modificar su código.

### Ejemplos de extensión
1. Caching ligero:
```dart
class CachedProductRepository implements ProductRepository {
  final ProductRepository _inner;
  List<ProductModel>? _cache;
  DateTime? _lastFetch;
  CachedProductRepository(this._inner);
  @override
  Future<List<ProductModel>> getAllProducts({int? limit, String? sort}) async {
    final fresh = _lastFetch != null &&
        DateTime.now().difference(_lastFetch!) < const Duration(minutes: 5);
    if (_cache != null && fresh) return _cache!;
    final data = await _inner.getAllProducts(limit: limit, sort: sort);
    _cache = data; _lastFetch = DateTime.now();
    return data;
  }
  // Demás métodos delegan ...
  @override Future<ProductModel> getProductById(int id) => _inner.getProductById(id);
  @override Future<List<String>> getCategories() => _inner.getCategories();
  @override Future<List<ProductModel>> getProductsByCategory(String c,{int? limit,String? sort}) =>
      _inner.getProductsByCategory(c, limit: limit, sort: sort);
}
```

2. Cliente/fachada opcional:
```dart
class FakeStoreClient {
  final FakeStoreRemoteDataSource _ds = FakeStoreRemoteDataSource();
  late final products = ProductRepositoryImpl(dataSource: _ds);
  late final users    = UserRepositoryImpl(dataSource: _ds);
  late final carts    = CartRepositoryImpl(dataSource: _ds);
}
```

3. Inyección de client con logging:
```dart
final loggingClient = LoggingClient(inner: http.Client());
final ds = FakeStoreRemoteDataSource(httpClient: loggingClient);
final repo = ProductRepositoryImpl(dataSource: ds);
```

### ¿Cuándo agregar más capas?
- Reglas de negocio compuestas → crea Use Cases.
- Reintentos / fallback de origen → decorator sobre DataSource o repos.
- Multi-backend (unir APIs) → una nueva capa de composición antes de la UI.

Con esto obtienes una base clara, extensible y fácil de leer desde el primer minuto.

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