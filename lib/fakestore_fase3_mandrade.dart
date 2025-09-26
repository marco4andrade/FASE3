/// Paquete Flutter para interactuar con la Fake Store API
///
/// Proporciona una API simple y fácil de usar para desarrolladores.
library;

// ===== API PÚBLICA =====
// Data Source principal (nuevo punto de entrada)
export 'data/datasources/fake_store_remote_datasource.dart';

// Repositorios concretos (implementaciones)
export 'data/repositories/product_repository_impl.dart';
export 'data/repositories/user_repository_impl.dart';
export 'data/repositories/cart_repository_impl.dart';

// Contratos (interfaces) de repositorio 
export 'domain/repositories/product_repository.dart';
export 'domain/repositories/user_repository.dart';
export 'domain/repositories/cart_repository.dart';

// Modelos de dominio
export 'domain/models/product_model.dart';
export 'domain/models/user_model.dart';
export 'domain/models/cart_model.dart';
