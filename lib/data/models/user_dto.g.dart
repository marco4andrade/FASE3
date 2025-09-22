// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  username: json['username'] as String,
  password: json['password'] as String,
  name: NameDto.fromJson(json['name'] as Map<String, dynamic>),
  address: AddressDto.fromJson(json['address'] as Map<String, dynamic>),
  phone: json['phone'] as String,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'username': instance.username,
  'password': instance.password,
  'name': instance.name,
  'address': instance.address,
  'phone': instance.phone,
};

NameDto _$NameDtoFromJson(Map<String, dynamic> json) => NameDto(
  firstname: json['firstname'] as String,
  lastname: json['lastname'] as String,
);

Map<String, dynamic> _$NameDtoToJson(NameDto instance) => <String, dynamic>{
  'firstname': instance.firstname,
  'lastname': instance.lastname,
};

AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) => AddressDto(
  city: json['city'] as String,
  street: json['street'] as String,
  number: (json['number'] as num).toInt(),
  zipcode: json['zipcode'] as String,
  geolocation: GeolocationDto.fromJson(
    json['geolocation'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AddressDtoToJson(AddressDto instance) =>
    <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'number': instance.number,
      'zipcode': instance.zipcode,
      'geolocation': instance.geolocation,
    };

GeolocationDto _$GeolocationDtoFromJson(Map<String, dynamic> json) =>
    GeolocationDto(lat: json['lat'] as String, long: json['long'] as String);

Map<String, dynamic> _$GeolocationDtoToJson(GeolocationDto instance) =>
    <String, dynamic>{'lat': instance.lat, 'long': instance.long};
