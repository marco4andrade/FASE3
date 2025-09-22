# Changelog

Todos los cambios notables de este proyecto se documentarán en este archivo.

## [1.0.2] - 2025-09-22

### Mejorado
- **Documentación del Ejemplo**: README completamente actualizado reflejando arquitectura BLoC
- **Arquitectura Clarificada**: Separación clara entre paquete (Clean Architecture) y ejemplo (BLoC)
- **Dependencias Documentadas**: flutter_bloc, equatable, get_it especificadas
- **Estados BLoC**: Documentación detallada de estados (Initial, Loading, Loaded, Error, Filtered)
- **Gestión de Estado**: Explicación completa del patrón BLoC implementado
- **Estructura del Proyecto**: Documentación mejorada de capas y responsabilidades


## [1.0.0] - 2025-09-22

### Lanzamiento Oficial

#### Características del Paquete
- **API Clean Architecture**: Implementación completa con `FakeStoreService` como interfaz principal
- **Interfaz Unificada**: Una sola clase para acceder a todos los endpoints de la Fake Store API
- **Entidades Tipadas**: `ProductEntity`, `UserEntity`, `CartEntity` con null safety completo
- **Facade Pattern**: Simplifica el acceso a la funcionalidad completa
- **Manejo de Errores**: Sistema robusto de gestión de excepciones
- **HTTP Client**: Comunicación eficiente con la Fake Store API

#### Arquitectura
- **Clean Architecture**: Separación clara de capas (Domain, Data, Presentation)
- **Repository Pattern**: Abstracción de fuentes de datos
- **Use Cases**: Lógica de negocio encapsulada
- **Dependency Injection**: Gestión limpia de dependencias

#### API Endpoints Disponibles
- **Productos**: `getAllProducts()`, `getProduct()`, `getCategories()`, `getProductsInCategory()`
- **Usuarios**: `getAllUsers()`, `getUser()`
- **Carritos**: `getAllCarts()`, `getCart()`, `getUserCarts()`

#### Características Técnicas
- **Testing Completo**: Suite de pruebas unitarias exhaustiva
- **Análisis de Código**: Configuración completa con flutter_lints
- **Build Tools**: json_serializable y build_runner configurados
- **MIT License**: Licencia permisiva para uso comercial y personal
- **Null Safety**: Compatible con null safety de Dart
- **Flutter Compatible**: Soporte completo para aplicaciones Flutter

#### Documentación
- **README**: Guía completa de instalación y uso
- **Ejemplos Prácticos**: Código de ejemplo para todos los casos de uso
- **Documentación de Arquitectura**: Explicación detallada del diseño
- **Aplicación de Ejemplo**: Implementación completa para referencia

### Uso Básico
```dart
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

final service = FakeStoreService();
final products = await service.getAllProducts();
final user = await service.getUser(1);
final carts = await service.getAllCarts();
```

## [0.0.1] - 2025-09-19

### Agregado
- Lanzamiento inicial del paquete `fakestore_fase3_mandrade`
- **Clean Architecture** implementada con Domain, Data y Presentation
- **FakeStoreService** como fachada principal
- **Entidades de dominio**: `ProductEntity`, `UserEntity`, `CartEntity`
- Suite de pruebas unitarias completa
- Documentación completa con ejemplos de uso
- Filtrado por categorías de productos
- Operaciones completas con carritos de compra
- Gestión de usuarios y perfiles
- Manejo de errores robusto
- Null safety compatible
- Análisis de código con linting estricto

### Características destacadas
- API intuitiva basada en Clean Architecture
- Entidades de dominio completamente tipadas
- Testing incluido con mocks
- Ejemplo funcional completo
- Documentación exhaustiva
- Compatible con Flutter 3.0+