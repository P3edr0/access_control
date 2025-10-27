import 'coordinates_dto.dart';
import 'street_dto.dart';
import 'timezone_dto.dart';

class AddressDto {
  final StreetDto street;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final CoordinatesDto coordinates;
  final TimezoneDto timezone;

  AddressDto({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) => AddressDto(
    street: StreetDto.fromJson(json['street']),
    city: json['city'],
    state: json['state'],
    country: json['country'],
    postcode: json['postcode'].toString(),
    coordinates: CoordinatesDto.fromJson(json['coordinates']),
    timezone: TimezoneDto.fromJson(json['timezone']),
  );
}
