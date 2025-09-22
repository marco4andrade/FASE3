# Changelog

Todos los cambios notables de este proyecto se documentarán en este archivo.

## [1.0.0] - 2025-09-21

### ⚡ BREAKING CHANGES
- 🗑️ **Eliminada API legacy**: Se eliminó completamente `FakeStoreApiClient` y modelos DTO (`Product`, `User`, `Cart`)
- 🎯 **Solo Clean Architecture**: El paquete ahora usa exclusivamente `FakeStoreService` con entidades de dominio
- � **API simplificada**: Una sola interfaz consistente y limpia
- 🧪 **Tests actualizados**: Tests enfocados únicamente en Clean Architecture

### Agregado
- 🚀 **Ejemplo completo**: Nueva aplicación que demuestra **todos los 11 métodos** de la API
- � **Navegación completa**: 3 pantallas (Products, Users, Carts) con NavigationBar
- 🎨 **UI moderna**: Material Design 3 con estados de loading, error y success
- 🛍️ **Products Screen**: `getAllProducts()`, `getProduct()`, `getCategories()`, `getProductsInCategory()`
- 👥 **Users Screen**: `getAllUsers()`, `getUser()`, `login()` 
- 🛒 **Carts Screen**: `getAllCarts()`, `getCart()`, `getUserCarts()`
- 📖 **Documentación actualizada**: README limpio sin referencias legacy

### Removido
- ❌ `FakeStoreApiClient` - Usar `FakeStoreService` en su lugar
- ❌ Modelos DTO (`Product`, `User`, `Cart`) - Usar entidades de dominio
- ❌ API legacy completa - Solo Clean Architecture disponible
- ❌ Tests de retrocompatibilidad - Solo tests de Clean Architecture

### Migración
```dart
// ❌ Antes (API legacy)
final client = FakeStoreApiClient();
final products = await client.getAllProducts(); // Retorna List<Product>

// ✅ Ahora (Clean Architecture)
final service = FakeStoreService();
final products = await service.getAllProducts(); // Retorna List<ProductEntity>
```

## [0.0.1] - 2025-09-19

### Agregado
- ✨ Lanzamiento inicial del paquete `fakestore_fase3_mandrade`
- 🏗️ **Clean Architecture** implementada con Domain, Data y Presentation
- 🎯 **FakeStoreService** como fachada principal
- 📦 **Entidades de dominio**: `ProductEntity`, `UserEntity`, `CartEntity`
- 🧪 Suite de pruebas unitarias completa
- 📱 Aplicación de ejemplo con interfaz Material 3
- 📚 Documentación completa con ejemplos de uso
- 🔐 Soporte para autenticación con tokens
- 📂 Filtrado por categorías de productos
- 🛒 Operaciones completas con carritos de compra
- 👥 Gestión de usuarios y perfiles
- ⚡ Manejo de errores robusto
- 🎯 Null safety compatible
- 🧹 Análisis de código con linting estricto

### Características destacadas
- API intuitiva basada en Clean Architecture
- Entidades de dominio completamente tipadas
- Testing incluido con mocks
- Ejemplo funcional completo
- Documentación exhaustiva
- Compatible con Flutter 3.0+
