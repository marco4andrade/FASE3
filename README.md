# Fase 3 - Fake Store API Client

Un paquete Flutter/Dart que implementa **Clean Architecture** para interactuar con la [Fake Store API](https://fakestoreapi.com/). Proporciona una interfaz ## 📱 Aplicación de Ejemplo

### Ejemplo Completo (`example_simple/`)
Aplicación completa con Material Design 3 que demuestra **todos los métodos de la API**:

#### 🛍️ **Pantalla Products**
- ✅ `getAllProducts()` - Lista con imágenes y filtros
- ✅ `getCategories()` - Chips de categorías  
- ✅ `getProductsInCategory()` - Filtrado dinámico
- ✅ `getProduct(id)` - Modal con detalles completos

#### 👥 **Pantalla Users**
- ✅ `getAllUsers()` - Lista de usuarios
- ✅ `getUser(id)` - Modal con dirección completa
- ✅ `login()` - Autenticación con token

#### 🛒 **Pantalla Carts**
- ✅ `getAllCarts()` - Lista de carritos, perfecta para prototipado, aprendizaje y desarrollo de aplicaciones de comercio electrónico.

## 🏗️ Arquitectura

Este paquete implementa **Clean Architecture** con las siguientes capas:

- **🏛️ Domain**: Entidades de negocio, contratos de repositorios y casos de uso
- **📡 Data**: DTOs, fuentes de datos remotos e implementaciones de repositorios  
- **🎨 Presentation**: Fachada simple (`FakeStoreService`) que oculta la complejidad

## ✨ Características

✅ **Clean Architecture** - Separación clara de responsabilidades y fácil testing  
✅ **API Simple** - Fachada intuitiva con métodos claros y documentados  
✅ **Completamente tipado** - Entidades de dominio con tipos seguros  
✅ **Manejo de errores** - Excepciones descriptivas para mejor debugging  
✅ **Testing completo** - Pruebas unitarias para todas las capas arquitectónicas  
✅ **Null safety** - Compatible con la seguridad de nulls de Dart  
✅ **Documentación completa** - Todos los métodos y clases están documentados  

### Endpoints soportados

- 🛍️ **Productos**: Obtener, filtrar y buscar productos
- 👥 **Usuarios**: Gestión de usuarios y perfiles  
- 🛒 **Carritos**: Operaciones con carritos de compra
- 🔐 **Autenticación**: Login y manejo de tokens
- 📂 **Categorías**: Filtrado por categorías de productos

## Instalación

Agrega `fakestore_fase3_mandrade` a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  fakestore_fase3_mandrade: ^0.0.1
```

Luego ejecuta:

```bash
flutter pub get
```

## 🚀 Uso básico

### Configuración inicial

```dart
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

// Crear el servicio (maneja toda la complejidad de Clean Architecture)
final service = FakeStoreService();

// El servicio implementa Clean Architecture internamente:
// Domain: ProductEntity, UserEntity, CartEntity
// Data: ProductDto, UserDto, CartDto + Remote DataSource
// Presentation: FakeStoreService (fachada simple)
```

### 🛍️ Trabajar con Productos

```dart
// Obtener todos los productos (retorna ProductEntity)
final products = await service.getAllProducts();

// Obtener productos con límite y ordenamiento
final limitedProducts = await service.getAllProducts(limit: 5, sort: 'asc');

// Obtener producto específico
final product = await service.getProduct(1);

// Obtener categorías disponibles
final categories = await service.getCategories();

// Obtener productos de una categoría
final categoryProducts = await service.getProductsInCategory('electronics');

// Los productos son entidades de dominio puras
print('${product.title} - \$${product.price}');
print('Rating: ${product.rating.rate}/5 (${product.rating.count} reviews)');
```

// Obtener productos por categoría
final electronics = await apiClient.getProductsInCategory('electronics');
```

### 👥 Gestión de Usuarios

```dart
// Obtener todos los usuarios (retorna UserEntity)
final users = await service.getAllUsers();

// Obtener usuarios con límite y ordenamiento
final limitedUsers = await service.getAllUsers(limit: 5, sort: 'desc');

// Obtener usuario específico
final user = await service.getUser(1);

// Acceso a datos del usuario con entidades ricas
print('${user.name.fullName}'); // Combina firstName + lastName automáticamente
print('Email: ${user.email}');
print('Usuario: ${user.username}');
print('Ciudad: ${user.address.city}');
print('Coordenadas: ${user.address.geolocation.latitude}, ${user.address.geolocation.longitude}');

// Autenticación
final token = await service.login('mor_2314', '83r5^_');
print('Token recibido: $token');
```

### 🛒 Operaciones con Carritos

```dart
// Obtener todos los carritos (retorna CartEntity)
final carts = await service.getAllCarts();

// Obtener carritos con filtros
final filteredCarts = await service.getAllCarts(
  limit: 5,
  sort: 'desc',
  startDate: DateTime.parse('2019-12-10'),
  endDate: DateTime.parse('2020-10-10'),
);

// Obtener carrito específico
final cart = await service.getCart(1);

// Obtener carritos de un usuario específico
final userCarts = await service.getUserCarts(1);

// Acceso a información rica del carrito
print('Usuario: ${cart.userId}');
print('Fecha: ${cart.date}');
print('Total de productos: ${cart.totalProducts}'); // Suma automática
print('Productos únicos: ${cart.products.length}');

// Iterar productos del carrito
for (final product in cart.products) {
  print('Producto ${product.productId}: ${product.quantity} unidades');
}
```

### ⚠️ Manejo de Errores

Manejo robusto de errores con excepciones descriptivas:

```dart
try {
  final product = await service.getProduct(999);
  print('Producto encontrado: ${product.title}');
} catch (e) {
  print('Error: $e');
  // El error contiene información específica sobre lo que falló
  // Ej: "Product with ID 999 not found" 
}
```

### 🧹 Liberación de Recursos

```dart
// Liberar recursos del cliente HTTP y conexiones
service.dispose();
```

## 🏛️ Arquitectura Clean

### Capas implementadas
- **🏛️ Domain**: Entidades de negocio puras (`ProductEntity`, `UserEntity`, `CartEntity`)
- **📡 Data**: DTOs para serialización y DataSources remotos
- **🎨 Presentation**: `FakeStoreService` como fachada simple
- **🔧 Use Cases**: Lógica de negocio encapsulada y reutilizable

### Beneficios
- **Testing independiente**: Cada capa se puede testear por separado
- **Mantenibilidad**: Separación clara de responsabilidades  
- **Extensibilidad**: Fácil agregar nuevas funcionalidades
- **Dominio puro**: Sin dependencias externas en las entidades

## 📊 Modelos de Datos

### Entidades de Dominio
- **`ProductEntity`** - Producto con información completa (título, precio, descripción, categoría, imagen, rating)
- **`UserEntity`** - Usuario con datos personales y de contacto
- **`CartEntity`** - Carrito con cálculos automáticos y lista de productos
- **`RatingEntity`** - Calificación con promedio y número de reseñas
- **`NameEntity`** - Nombre con métodos útiles (`fullName`)
- **`AddressEntity`** - Dirección completa con geolocalización
- **`GeolocationEntity`** - Coordenadas de latitud y longitud
- **`CartProductEntity`** - Producto en carrito con cantidad

## 📱 Aplicación de Ejemplo

### Ejemplo Simple (`example_simple/`)
Aplicación simple y limpia que demuestra el uso básico del paquete:

#### ✨ **Características**
- **Una sola pantalla**: Lista de productos fácil de entender
- **Interfaz moderna**: Material Design 3 con UI responsiva
- **Manejo completo de estados**: Carga, error y éxito
- **Detalles interactivos**: Modal con información completa del producto
- **Solo ~200 líneas**: Código fácil de leer y modificar

#### �️ **Funcionalidades implementadas**
- ✅ `getAllProducts()` - Lista completa de productos
- ✅ Imágenes, títulos, precios y calificaciones
- ✅ Modal de detalles con descripción completa
- ✅ Botón de recarga y manejo de errores
- ✅ `getCart(id)` - Modal con productos del carrito
- ✅ `getUserCarts()` - Filtro por usuario

#### **Características:**
- **NavigationBar** con 3 pestañas
- **Estados completos**: Loading, Error, Empty, Success
- **UI moderna** con Material Design 3
- **Manejo robusto de errores** con retry
- **11/11 métodos demostrados** (100% cobertura)

### Ejecutar el Ejemplo

```bash
cd example_simple
flutter pub get
flutter run
```

## 🧪 Testing

### Tests incluidos
El paquete incluye tests completos para todas las capas de Clean Architecture:

```bash
# Ejecutar todos los tests
flutter test

# Solo tests de Clean Architecture
flutter test test/clean_architecture_test.dart
```

### Testing en tu aplicación

```dart
import 'package:http/testing.dart';
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';
import 'dart:convert';

// Mock del cliente HTTP para testing
final mockClient = MockClient((request) async {
  // Simular respuesta de productos
  if (request.url.path.contains('/products')) {
    return http.Response(json.encode([
      {
        'id': 1,
        'title': 'Test Product',
        'price': 29.99,
        'description': 'Test description',
        'category': 'electronics',
        'image': 'https://test.com/image.jpg',
        'rating': {'rate': 4.5, 'count': 10}
      }
    ]), 200);
  }
  
  return http.Response('Not Found', 404);
});

// Usar el mock en tests
final service = FakeStoreService(httpClient: mockClient);
final products = await service.getAllProducts();

// Verificar que retorna ProductEntity
expect(products, isA<List<ProductEntity>>());
expect(products.first.title, equals('Test Product'));
```

## Contribuir

¡Las contribuciones son bienvenidas! Por favor:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agrega nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT - consulta el archivo [LICENSE](LICENSE) para más detalles.

## API Reference

Para más información sobre la API utilizada, consulta la [documentación oficial de Fake Store API](https://fakestoreapi.com/docs).

## Changelog

Consulta [CHANGELOG.md](CHANGELOG.md) para ver el historial de cambios.
