# FakeStore API - Ejemplo Simple

Este ejemplo demuestra lo **súper fácil** que es usar el paquete `fakestore_fase3_mandrade`.

## 🎯 ¿Qué hace este ejemplo?

Una aplicación simple con **9 botones** que demuestran **todos los métodos** disponibles en el paquete:


- ✅ **Obtener Productos** - `service.getAllProducts()`
- ✅ **Obtener Usuarios** - `service.getAllUsers()`  
- ✅ **Obtener Carritos** - `service.getAllCarts()`
- ✅ **Obtener Categorías** - `service.getCategories()`

- ✅ **Producto Específico** - `service.getProduct(1)`
- ✅ **Productos por Categoría** - `service.getProductsInCategory('electronics')`
- ✅ **Usuario Específico** - `service.getUser(1)`
- ✅ **Carrito Específico** - `service.getCart(1)`
- ✅ **Carritos de Usuario** - `service.getUserCarts(1)`

## 🚀 Cómo ejecutar

### Opción 1: Desde el ejemplo del paquete

1. Navega al directorio del ejemplo:
```bash
cd example
```

2. Instala las dependencias:
```bash
flutter pub get
```

3. Ejecuta la aplicación:
```bash
flutter run
```

### Opción 2: Crear tu propia aplicación

1. Crea un nuevo proyecto Flutter:
```bash
flutter create mi_app_fakestore
cd mi_app_fakestore
```

2. Agrega el paquete a tu `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  fakestore_fase3_mandrade: ^1.0.3
```

3. Instala las dependencias y ejecuta:
```bash
flutter pub get
flutter run
```

## 💡 Código principal

Es **súper simple** usar el paquete:

```dart
import 'package:fakestore_fase3_mandrade/fakestore_fase3_mandrade.dart';

// 1. Crear el servicio
final FakeStoreService service = FakeStoreService();

// 2. Usar cualquier método (ejemplos)
final products = await service.getAllProducts();
final users = await service.getAllUsers();
final carts = await service.getAllCarts();
final categories = await service.getCategories();

// Métodos específicos
final product = await service.getProduct(1);
final electronicsProducts = await service.getProductsInCategory('electronics');
final user = await service.getUser(1);
final cart = await service.getCart(1);
final userCarts = await service.getUserCarts(1);

// 3. Liberar recursos al terminar
service.dispose();
```

## � Dependencias

Este ejemplo solo necesita:

```yaml
dependencies:
  flutter:
    sdk: flutter
  fakestore_fase3_mandrade: ^1.0.3  # ¡El paquete publicado en pub.dev!
```


## 🎨 Características del ejemplo

### 🖥️ **Interfaz Simple**
- **9 botones** para probar cada método
- **Área de resultados** que muestra la respuesta de la API
- **Scrollable** para pantallas pequeñas
- **Material Design 3** con colores adaptativos

### 📱 **Funcionalidad Completa**
- **Manejo de errores**: Cada método maneja sus propios errores
- **Estados de carga**: Feedback visual durante las llamadas a la API
- **Resultados legibles**: Información formateada para fácil lectura
- **Cleanup automático**: Liberación de recursos al cerrar la app

### 🔧 **Arquitectura Simple**
- **StatefulWidget** básico con Flutter
- **FakeStoreService** del paquete (que internamente usa Clean Architecture)
- **Gestión de estado** con `setState()` nativo de Flutter
- **Sin dependencias externas** complejas

## ✨ Lo que puedes aprender

### 🎯 **Uso del Paquete**
- Cómo importar y usar `fakestore_fase3_mandrade`
- Todos los métodos disponibles en `FakeStoreService`
- Manejo básico de errores con `try-catch`
- Liberación de recursos con `dispose()`

### 📱 **Flutter Básico**
- Widgets básicos: `Scaffold`, `Column`, `ElevatedButton`, `Card`
- Gestión de estado con `StatefulWidget` y `setState()`
- Layout responsivo con `SingleChildScrollView`
- Manejo de ciclo de vida con `dispose()`

## 🎉 ¿Por qué este ejemplo es perfecto?

✅ **Súper simple** - Solo un archivo `main.dart`  
✅ **Completo** - Demuestra todos los 9 métodos del paquete  
✅ **Fácil de entender** - Código limpio y comentado  
✅ **Funcional** - Realmente funciona con la API real  
✅ **Copiable** - Puedes copiar cualquier método a tu proyecto  

## 📊 Resumen de métodos demostrados

| Método | Función | Estado |
|--------|---------|--------|
| `getAllProducts()` | Obtiene todos los productos | ✅ |
| `getAllUsers()` | Obtiene todos los usuarios | ✅ |
| `getAllCarts()` | Obtiene todos los carritos | ✅ |
| `getCategories()` | Obtiene todas las categorías | ✅ |
| `getProduct(id)` | Obtiene un producto específico | ✅ |
| `getProductsInCategory()` | Filtra productos por categoría | ✅ |
| `getUser(id)` | Obtiene un usuario específico | ✅ |
| `getCart(id)` | Obtiene un carrito específico | ✅ |
| `getUserCarts(userId)` | Obtiene carritos de un usuario | ✅ |



---

¡Con este ejemplo tienes todo lo que necesitas para empezar a usar `fakestore_fase3_mandrade` en tus proyectos! 🚀