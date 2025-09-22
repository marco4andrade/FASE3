import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_dto.g.dart';

/// DTO para usuarios desde la API
@JsonSerializable()
class UserDto {
  final int id;
  final String email;
  final String username;
  final String password;
  final NameDto name;
  final AddressDto address;
  final String phone;

  const UserDto({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  /// Mapper: DTO a Entidad
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      username: username,
      name: name.toEntity(),
      address: address.toEntity(),
      phone: phone,
    );
  }
}

@JsonSerializable()
class NameDto {
  final String firstname;
  final String lastname;

  const NameDto({required this.firstname, required this.lastname});

  factory NameDto.fromJson(Map<String, dynamic> json) =>
      _$NameDtoFromJson(json);
  Map<String, dynamic> toJson() => _$NameDtoToJson(this);

  NameEntity toEntity() {
    return NameEntity(firstName: firstname, lastName: lastname);
  }
}

@JsonSerializable()
class AddressDto {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeolocationDto geolocation;

  const AddressDto({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  AddressEntity toEntity() {
    return AddressEntity(
      city: city,
      street: street,
      number: number,
      zipCode: zipcode,
      geolocation: geolocation.toEntity(),
    );
  }
}

@JsonSerializable()
class GeolocationDto {
  final String lat;
  final String long;

  const GeolocationDto({required this.lat, required this.long});

  factory GeolocationDto.fromJson(Map<String, dynamic> json) =>
      _$GeolocationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GeolocationDtoToJson(this);

  GeolocationEntity toEntity() {
    return GeolocationEntity(
      latitude: double.tryParse(lat) ?? 0.0,
      longitude: double.tryParse(long) ?? 0.0,
    );
  }
}
