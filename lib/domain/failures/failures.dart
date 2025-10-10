/// Clase base para representar fallos en la aplicación.
/// Utilizada con Either para manejo de errores funcional.
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

/// Fallo de servidor/API (códigos de estado HTTP 4xx, 5xx)
class ServerFailure extends Failure {
  final int statusCode;
  
  const ServerFailure({
    required this.statusCode,
    required String message,
  }) : super(message);

  @override
  String toString() => 'Error del servidor ($statusCode): $message';
}

/// Fallo de conectividad de red
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Error de conexión de red'])
      : super(message);
}

/// Fallo de parsing de datos JSON
class ParsingFailure extends Failure {
  const ParsingFailure([String message = 'Error al procesar los datos'])
      : super(message);
}

/// Fallo de autenticación específico
class AuthenticationFailure extends Failure {
  const AuthenticationFailure([String message = 'Credenciales inválidas'])
      : super(message);
}

/// Fallo de validación de entrada
class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

/// Fallo genérico/desconocido
class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'Error desconocido']) : super(message);
}

/// Fallo cuando no se encuentra un recurso específico
class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Recurso no encontrado'])
      : super(message);
}