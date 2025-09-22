# FakeStore Fase3 Mandrade

Un paquete Flutter profesional que implementa **Clean Architecture** para interactuar con la [Fake Store API](https://fakestoreapi.com/). Ideal para prototipado rápido, aprendizaje y desarrollo de aplicaciones e-commerce.

## ✨ Características

✅ **Clean Architecture** - Código mantenible y testeable  
✅ **API Simple** - Una sola clase `FakeStoreService` para todo  
✅ **Completamente tipado** - Entidades seguras con null safety  
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
  fakestore_fase3_mandrade: ^1.0.0
```

## 🚀 Uso Rápido

```dart
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

// Crear el servicio
final service = FakeStoreService();

// Obtener productos
final products = await service.getAllProducts();
print('${products.length} productos disponibles');

// Obtener producto específico
final product = await service.getProduct(1);
print('${product.title} - \$${product.price}');

// Obtener categorías
final categories = await service.getCategories();
print('Categorías: ${categories.join(", ")}');

// Obtener usuarios
final users = await service.getAllUsers();
print('${users.length} usuarios registrados');

// Obtener carritos
final carts = await service.getAllCarts();
print('${carts.length} carritos activos');

// Limpiar recursos
service.dispose();
```

## 📊 Ejemplos Detallados

### 🛍️ Productos

```dart
// Lista con filtros
final products = await service.getAllProducts(limit: 10, sort: 'desc');

// Categorías disponibles
final categories = await service.getCategories();
// ['electronics', 'jewelery', 'men\'s clothing', 'women\'s clothing']

// Filtrar por categoría
final electronics = await service.getProductsInCategory('electronics');

// Producto específico
final product = await service.getProduct(1);
print('${product.title} - \$${product.price}');
print('Rating: ${product.rating.rate}/5 (${product.rating.count} reviews)');
```

### 👥 Usuarios

```dart
// Lista de usuarios
final users = await service.getAllUsers(limit: 5);

// Usuario específico
final user = await service.getUser(1);
print('${user.name.firstName} ${user.name.lastName}');
print('Email: ${user.email}');
print('Ciudad: ${user.address.city}');
```

### 🛒 Carritos

```dart
// Todos los carritos
final carts = await service.getAllCarts();

// Carrito específico
final cart = await service.getCart(1);
print('Carrito del usuario: ${cart.userId}');
print('Total productos: ${cart.totalProducts}');

// Carritos de un usuario
final userCarts = await service.getUserCarts(1);
print('Usuario tiene ${userCarts.length} carritos');

// Iterar productos del carrito
for (final product in cart.products) {
  print('Producto ${product.productId}: ${product.quantity} unidades');
}
```

## 🏛️ Arquitectura

Implementa **Clean Architecture** con tres capas:

- **🎯 Domain**: Entidades puras (`ProductEntity`, `UserEntity`, `CartEntity`)
- **📡 Data**: DTOs y conexiones HTTP  
- **🎨 Presentation**: `FakeStoreService` como fachada simple

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