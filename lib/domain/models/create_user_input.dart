/// Datos necesarios para crear un nuevo usuario en FakeStore API.
/// Contiene también el password (no se expone en `UserModel`).
class CreateUserInput {
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String city;
  final String street;
  final int number;
  final String zipCode;
  final String geoLat; // La API espera strings para lat/long
  final String geoLong;
  final String phone;

  const CreateUserInput({
    required this.email,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.street,
    required this.number,
    required this.zipCode,
    required this.geoLat,
    required this.geoLong,
    required this.phone,
  });

  /// Fábrica conveniente para creación mínima (solo credenciales básicas).
  /// Los demás campos se rellenan con valores por defecto.
  factory CreateUserInput.minimal({
    required String email,
    required String username,
    required String password,
  }) => CreateUserInput(
        email: email,
        username: username,
        password: password,
        firstName: 'N/A',
        lastName: 'N/A',
        city: 'N/A',
        street: 'N/A',
        number: 0,
        zipCode: '00000',
        geoLat: '0',
        geoLong: '0',
        phone: 'N/A',
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
        'name': {
          'firstname': firstName,
          'lastname': lastName,
        },
        'address': {
          'city': city,
          'street': street,
          'number': number,
          'zipcode': zipCode,
          'geolocation': {
            'lat': geoLat,
            'long': geoLong,
          },
        },
        'phone': phone,
      };
}
