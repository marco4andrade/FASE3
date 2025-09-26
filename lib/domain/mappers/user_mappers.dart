import '../models/user_model.dart';

/// Mapeador desde un mapa JSON (decodificado) hacia [UserModel].
///
/// Detalles:
/// - Usa valores por defecto si faltan campos (string vacío / 0).
/// - Parsea coordenadas de geolocalización de forma tolerante usando `double.tryParse`.
/// - No expone ni procesa campos sensibles como `password` aunque vengan en la respuesta.
class UserMapper {
  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] as num).toInt(),
      email: (map['email'] ?? '') as String,
      username: (map['username'] ?? '') as String,
      name: NameModel(
        firstName: (map['name']?['firstname'] ?? '') as String,
        lastName: (map['name']?['lastname'] ?? '') as String,
      ),
      address: AddressModel(
        city: (map['address']?['city'] ?? '') as String,
        street: (map['address']?['street'] ?? '') as String,
        number: (map['address']?['number'] as num?)?.toInt() ?? 0,
        zipCode: (map['address']?['zipcode'] ?? '') as String,
        geolocation: GeolocationModel(
          latitude: double.tryParse((map['address']?['geolocation']?['lat'] ?? '0') as String) ?? 0.0,
          longitude: double.tryParse((map['address']?['geolocation']?['long'] ?? '0') as String) ?? 0.0,
        ),
      ),
      phone: (map['phone'] ?? '') as String,
    );
  }
}
