# Changelog

Todos los cambios notables de este proyecto se documentarán en este archivo.

## [1.0.3] - 2025-09-22

## [2.0.0] - 2025-09-26

## [2.1.0] - 2025-10-09

## [2.2.0] - 2025-10-10

### Mejorado
- Gestión de errores: refactorizada la estrategia de errores para usar `Either` (paquete `dartz`) y tipos `Failure` específicos.

### Detalles
- `FakeStoreRemoteDataSource` ahora devuelve `Either<Failure, T>` capturando errores de red, parsing y HTTP y mapeándolos a `Left(Failure)`.
- Se añadieron clases de fallo (`ServerFailure`, `NetworkFailure`, `ParsingFailure`, `AuthenticationFailure`, `NotFoundFailure`, `ValidationFailure`, `UnknownFailure`).
- Repositorios y use-cases ahora propagan `Either` para que la UI/Controladores puedan manejar `Left/Right` con `fold`.

### Beneficios
- Manejo de errores tipado y predecible, más fácil de testear y componer.
- Mensajes de error más descriptivos para la UI.


### Añadido
- Creación de usuario: método `createUser(CreateUserInput)` en `FakeStoreRemoteDataSource` y repositorio.
- Autenticación: método `login(username,password)` retorna token JWT.
- Modelo `CreateUserInput` con fábrica `CreateUserInput.minimal` para alta rápida (username, email, password).
- Tests unitarios para creación y login (incluyendo status 201 tolerado en login).

### Mejorado
- Ejemplo: botones y formularios (bottom sheets) para crear usuario y login.
- README: documentación actualizada con login y creación minimal.

### Cambiado
- `login` ahora acepta `200` o `201` como respuesta exitosa según comportamiento observado en algunos entornos.

### Notas
- Versión menor (minor) porque agrega funcionalidades sin romper compatibilidad.
- Formularios del ejemplo no forman parte del API público (solo demostración).

### 🚨 Breaking Change
- Eliminada la fachada `FakeStoreService` (redundancia). Ahora el punto de entrada recomendado es `FakeStoreRemoteDataSource` junto con los repositorios `ProductRepositoryImpl`, `UserRepositoryImpl`, `CartRepositoryImpl`.

### ✅ Razones del cambio
1. Reducir capas innecesarias y hacer más transparente el flujo HTTP -> Modelo.
2. Evitar duplicación de API y mantenimiento redundante.
3. Facilitar testing directo de data source y repositorios.
4. Permitir que los usuarios construyan su propio "client" si necesitan una fachada personalizada.

### 🧩 Migración rápida
Antes:
```dart
final service = FakeStoreService();
final products = await service.getAllProducts();
service.dispose();
```
Después:
```dart
final ds = FakeStoreRemoteDataSource();
final productsRepo = ProductRepositoryImpl(ds);
final products = await productsRepo.getAllProducts();
```

### ✨ Extras
- Exportadas interfaces de repositorio para facilitar mocking.
- README actualizado con ejemplos y snippet opcional de `FakeStoreClient`.

### 🔄 Ajuste posterior (pre-publicación)
- Se revirtió el `FakeStoreRemoteDataSource` de métodos estáticos a instancia para encapsular el `http.Client`, y luego se simplificó eliminando `dispose()` al considerar el paquete de uso básico.
- Los repos aceptan `dataSource:` explícito (opcional; crean uno interno si no se pasa).


### ✨ Actualizado - Ejemplo Completo
- **🔥 9 Botones Funcionales**: Cada método tiene su propio botón de prueba
- **📋 Métodos Generales**: getAllProducts(), getAllUsers(), getAllCarts(), getCategories()
- **🎯 Métodos Específicos**: getProduct(id), getProductsInCategory(), getUser(id), getCart(id), getUserCarts(userId)
- **📱 UI Mejorada**: ScrollView para manejar todos los botones, separación visual clara
- **📚 README Actualizado**: Documentación completamente renovada y sin duplicaciones

### 🚀 Mejoras del Ejemplo
- **Interfaz Scrollable**: SingleChildScrollView para pantallas pequeñas
- **Separación Clara**: Sección de métodos generales vs específicos
- **Resultados Detallados**: Cada método muestra información relevante y específica
- **Manejo de Errores**: Try-catch individual para cada método
- **Código Limpio**: Estructura clara y comentarios útiles

### 📖 Documentación
- **README Reorganizado**: Estructura limpia sin contenido duplicado o mezclado
- **Tabla de Métodos**: Resumen visual de los 9/9 métodos implementados (100%)
- **Instrucciones Claras**: Pasos precisos para ejecutar el ejemplo
- **Código de Ejemplo**: Snippets actualizados mostrando todos los métodos disponibles

### 🔄 Refactor Arquitectura (post 1.0.3 - no publicado)
- Migración de Entidades + DTOs a Modelos + Mappers en capa Domain
- Eliminación de `*Entity` y `*Dto` en favor de `*Model` y mapeo manual `fromMap`
- DataSource ahora retorna directamente modelos de dominio
- Simplificación de capas para propósito educativo del reto

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