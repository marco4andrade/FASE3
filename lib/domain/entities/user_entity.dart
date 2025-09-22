/// Entidad pura del usuario (sin dependencias externas)
class UserEntity {
  final int id;
  final String email;
  final String username;
  final NameEntity name;
  final AddressEntity address;
  final String phone;

  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
  });

  @override
  String toString() {
    return 'UserEntity{id: $id, username: $username, email: $email}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Entidad del nombre
class NameEntity {
  final String firstName;
  final String lastName;

  const NameEntity({required this.firstName, required this.lastName});

  /// Nombre completo concatenado
  String get fullName => '$firstName $lastName';

  @override
  String toString() => fullName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameEntity &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName;

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode;
}

/// Entidad de dirección
class AddressEntity {
  final String city;
  final String street;
  final int number;
  final String zipCode;
  final GeolocationEntity geolocation;

  const AddressEntity({
    required this.city,
    required this.street,
    required this.number,
    required this.zipCode,
    required this.geolocation,
  });

  @override
  String toString() {
    return 'AddressEntity{street: $street $number, city: $city, zipCode: $zipCode}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressEntity &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          street == other.street &&
          number == other.number &&
          zipCode == other.zipCode;

  @override
  int get hashCode =>
      city.hashCode ^ street.hashCode ^ number.hashCode ^ zipCode.hashCode;
}

/// Entidad de geolocalización
class GeolocationEntity {
  final double latitude;
  final double longitude;

  const GeolocationEntity({required this.latitude, required this.longitude});

  @override
  String toString() {
    return 'GeolocationEntity{lat: $latitude, long: $longitude}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeolocationEntity &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
