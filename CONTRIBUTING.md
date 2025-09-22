# Contributing to fakestore_fase3_mandrade

¡Gracias por tu interés en contribuir a `fakestore_fase3_mandrade`! Este documento proporciona pautas para contribuir al proyecto.

## Cómo contribuir

### Reportar bugs

Si encuentras un bug, por favor:

1. Verifica que no exista ya un issue similar
2. Crea un nuevo issue con:
   - Descripción clara del problema
   - Pasos para reproducir el bug
   - Comportamiento esperado vs actual
   - Versión de Flutter/Dart
   - Información del dispositivo/plataforma

### Sugerir mejoras

Para sugerir nuevas características:

1. Abre un issue de tipo "Feature Request"
2. Describe claramente la funcionalidad deseada
3. Explica por qué sería útil
4. Proporciona ejemplos de uso si es posible

### Pull Requests

1. Fork el repositorio
2. Crea una rama desde `main`: `git checkout -b feature/mi-nueva-funcionalidad`
3. Implementa tus cambios
4. Agrega/actualiza tests según sea necesario
5. Asegúrate de que todos los tests pasan: `flutter test`
6. Verifica que el código pase el análisis: `flutter analyze`
7. Actualiza la documentación si es necesario
8. Commit tus cambios con mensajes descriptivos
9. Push a tu fork y crea un Pull Request

### Estándares de código

- Sigue las [convenciones de código de Dart](https://dart.dev/guides/language/effective-dart)
- Usa `flutter format` para formatear el código
- Mantén la cobertura de tests alta
- Documenta APIs públicas
- Usa nombres descriptivos para variables y funciones

### Tests

- Todos los nuevos features deben incluir tests
- Los tests deben pasar antes de enviar el PR
- Usa mocks para dependencies externas
- Mantén los tests simples y enfocados

### Documentación

- Actualiza el README.md si es necesario
- Documenta métodos y clases públicas
- Incluye ejemplos de uso
- Actualiza el CHANGELOG.md

## Configuración del entorno de desarrollo

1. Clona el repositorio:
   ```bash
   git clone https://github.com/marco4andrade/FASE3.git
   cd FASE3
   ```

2. Instala dependencias:
   ```bash
   flutter pub get
   ```

3. Ejecuta los tests:
   ```bash
   flutter test
   ```

4. Ejecuta el ejemplo:
   ```bash
   cd example
   flutter pub get
   flutter run
   ```

## Estructura del proyecto

```
lib/
├── src/
│   ├── models/          # Modelos de datos
│   └── services/        # Cliente API
└── fakestore_fase3_mandrade.dart         # Archivo principal de exportación
test/                   # Tests unitarios  
example/               # Aplicación de ejemplo
```

## Proceso de release

1. Los maintainers revisarán el PR
2. Una vez aprobado, se hará merge a `main`
3. Se actualizará la versión en `pubspec.yaml`
4. Se creará un tag de release
5. Se actualizará el CHANGELOG.md

¡Gracias por contribuir! 🎉