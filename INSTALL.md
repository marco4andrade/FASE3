# Instalación Local

## Para desarrolladores

Si quieres contribuir al proyecto o usar la versión en desarrollo:

### 1. Clonar el repositorio

```bash
git clone https://github.com/marco4andrade/FASE3.git
cd FASE3
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Generar archivos

```bash
flutter packages pub run build_runner build
```

### 4. Ejecutar tests

```bash
flutter test
```

### 5. Ejecutar el ejemplo

```bash
cd example
flutter pub get
flutter run
```

## Usar versión local en tu proyecto

Para usar la versión local del paquete en tu proyecto Flutter:

```yaml
dependencies:
  fakestore_fase3_mandrade:
    path: /ruta/a/FASE3
```

O si está en el mismo directorio:

```yaml
dependencies:
  fakestore_fase3_mandrade:
    path: ../FASE3
```

## Estructura del proyecto

```
FASE3/
├── lib/
│   ├── src/
│   │   ├── models/       # Modelos de datos
│   │   └── services/     # Cliente API
│   └── fakestore_fase3_mandrade.dart      # Exportaciones principales
├── test/                # Tests unitarios
├── example/             # Aplicación de ejemplo
├── .github/             # Workflows de GitHub
└── docs/               # Documentación adicional
```

## Comandos útiles

```bash
# Formatear código
dart format .

# Analizar código
flutter analyze

# Ejecutar tests con coverage
flutter test --coverage

# Generar documentación
dart doc

# Limpiar proyecto
flutter clean
```