/// Paquete Flutter para interactuar con la Fake Store API
///
/// Proporciona una API simple y fácil de usar para desarrolladores.
library;

// ===== API PÚBLICA (Clean Architecture) =====
// Exportar el servicio principal (Facade)
export 'presentation/fake_store_service.dart';

// Exportar entidades del dominio (modelos puros)
export 'domain/entities/product_entity.dart';
export 'domain/entities/user_entity.dart';
export 'domain/entities/cart_entity.dart';
