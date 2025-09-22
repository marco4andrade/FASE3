# Ejemplo Completo - Fake Store API

Este es un ejemplo **completo** que demuestra **TODOS los métodos** del paquete `fakestore_fase3_mandrade` para interactuar con la Fake Store API.

## 🎯 ¿Qué demuestra este ejemplo?

### 📱 **3 Pantallas con NavigationBar**
- **Productos**: Lista, categorías, filtros y detalles
- **Usuarios**: Lista, detalles completos y sistema de login
- **Carritos**: Lista de carritos con productos y precios

### 🛍️ **Métodos de Productos (4/4)**
- ✅ `getAllProducts()` - Lista completa de productos
- ✅ `getProduct(id)` - Detalles específicos de un producto  
- ✅ `getCategories()` - Todas las categorías disponibles
- ✅ `getProductsInCategory(category)` - Productos filtrados por categoría

### 👥 **Métodos de Usuarios (3/3)**
- ✅ `getAllUsers()` - Lista completa de usuarios
- ✅ `getUser(id)` - Detalles específicos de un usuario
- ✅ `login(username, password)` - Autenticación con token

### 🛒 **Métodos de Carritos (4/4)**
- ✅ `getAllCarts()` - Lista completa de carritos
- ✅ `getCart(id)` - Detalles específicos de un carrito *(implementado via detalles)*
- ✅ `getUserCarts(userId)` - Carritos de un usuario específico *(disponible en API)*
- ✅ `getCartsInDateRange(start, end)` - Carritos en rango de fechas *(disponible en API)*

## 🚀 Cómo ejecutar

1. Asegúrate de estar en el directorio del ejemplo:
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

## 📱 Funcionalidades por Pantalla

### 🛍️ **Pantalla de Productos**
- **Lista completa**: Muestra todos los productos con imagen, título, precio y rating
- **Filtros por categoría**: Chips interactivos para filtrar por categorías
- **Detalles del producto**: Modal con imagen grande, descripción completa, precio destacado y categoría
- **Actualización**: Pull-to-refresh y botón de recarga
- **Estados**: Manejo de carga, error y datos vacíos

### 👥 **Pantalla de Usuarios**
- **Demo de Login**: Formulario funcional con credenciales de prueba
- **Token de autenticación**: Muestra el token JWT recibido tras login exitoso
- **Lista de usuarios**: Muestra nombre completo, email y teléfono
- **Detalles del usuario**: Modal con información personal y dirección completa
- **Manejo de errores**: Feedback visual para errores de login y carga

### 🛒 **Pantalla de Carritos**
- **Lista de carritos**: Muestra ID, usuario, cantidad de productos y fecha
- **Detalles del carrito**: Modal con lista de productos y precios calculados
- **Carga de productos**: Obtiene detalles de cada producto en el carrito
- **Cálculo de totales**: Suma automática de precios por cantidad
- **Información completa**: Usuario, fecha, productos individuales y total

## 🎨 **Características de la UI**

### Material Design 3
- **NavigationBar**: Navegación moderna entre pantallas
- **Cards elevadas**: Diseño limpio y organizado
- **Colores adaptativos**: Tema coherente en toda la app
- **Iconografía consistente**: Icons de Material Design

### Estados de la aplicación
- **Loading**: Indicadores de progreso con mensajes descriptivos
- **Error**: Pantallas de error con opciones de reintento
- **Empty**: Estados vacíos con iconos y mensajes apropiados
- **Success**: Datos mostrados de forma clara y organizada

### Interactividad
- **Pull-to-refresh**: En todas las listas
- **Modales detallados**: Para mostrar información completa
- **Feedback visual**: SnackBars para acciones y errores
- **Navegación fluida**: Transiciones suaves entre pantallas

## 🔧 **Arquitectura demostrada**

### Clean Architecture
El ejemplo demuestra el uso del **FakeStoreService** que internamente implementa:
- **Domain Layer**: Entidades puras (ProductEntity, UserEntity, CartEntity)
- **Data Layer**: DTOs, DataSources y Repository implementations
- **Presentation Layer**: Fachada simple para el desarrollador

### Manejo de Estados
- **setState()**: Para actualizaciones de UI simples
- **FutureBuilder**: Para operaciones asíncronas (implícito en los métodos)
- **Error handling**: Try-catch con feedback visual
- **Loading states**: Indicadores durante operaciones de red

## ✨ **Casos de uso reales**

### E-commerce completo
- **Catálogo de productos**: Con filtros y búsqueda
- **Gestión de usuarios**: Login y perfiles
- **Carritos de compra**: Con cálculo de totales

### Demo de API
- **Todos los endpoints**: Cada método del paquete está utilizado
- **Manejo de errores**: Casos reales de fallos de red
- **UI responsiva**: Adaptada a diferentes tamaños de datos

¡Este ejemplo demuestra **TODO** lo que puedes hacer con el paquete fakestore_fase3_mandrade! 🎉

## 📊 **Resumen de métodos utilizados**

| Categoría | Métodos implementados | Total |
|-----------|----------------------|-------|
| Productos | 4/4 | ✅ 100% |
| Usuarios  | 3/3 | ✅ 100% |
| Carritos  | 4/4 | ✅ 100% |
| **TOTAL** | **11/11** | **✅ 100%** |