/// Representa un usuario registrado en la Fake Store API.
///
/// Combina datos básicos de autenticación ligera (username/email) con
/// información de perfil y dirección. Se mantiene deliberadamente simple.
/// No expone password por seguridad (la API original regresa un campo, pero
/// evitamos propagarlo a la capa de dominio de ejemplo).
class UserModel {
  final int id;
  final String email;
  final String username;
  final NameModel name;
  final AddressModel address;
  final String phone;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
  });

  @override
  String toString() => 'UserModel(id: $id, username: $username)';
}

/// Nombre estructurado del usuario.
/// Permite derivar el nombre completo mediante [fullName].
class NameModel {
  final String firstName;
  final String lastName;

  const NameModel({required this.firstName, required this.lastName});

  String get fullName => '$firstName $lastName';
}

/// Dirección física del usuario.
/// Incluye coordenadas para potencial uso en mapas o filtros.
class AddressModel {
  final String city;
  final String street;
  final int number;
  final String zipCode;
  final GeolocationModel geolocation;

  const AddressModel({
    required this.city,
    required this.street,
    required this.number,
    required this.zipCode,
    required this.geolocation,
  });
}

/// Coordenadas geográficas asociadas a la dirección del usuario.
///
/// - [latitude] y [longitude] en formato decimal.
class GeolocationModel {
  final double latitude;
  final double longitude;

  const GeolocationModel({required this.latitude, required this.longitude});
}
