import 'coordinates_model.dart';
import 'street_model.dart';
import 'timezone_model.dart';

class AddressModel {
  final StreetModel street;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final CoordinatesModel coordinates;
  final TimezoneModel timezone;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  Map<String, dynamic> toMap() => {
    'number': street.number,
    'street': street.name,
    'city': city,
    'state': state,
    'country': country,
    'postcode': postcode,
    'coordinates': coordinates.toMap(),
    'timezone': timezone.toMap(),
  };

  factory AddressModel.fromMap(Map<String, dynamic> map) => AddressModel(
    street: StreetModel(
      number: map['number'] as int,
      name: map['street'] as String,
    ),
    city: map['city'] as String,
    state: map['state'] as String,
    country: map['country'] as String,
    postcode: map['postcode'].toString(),
    coordinates: CoordinatesModel.fromMap(
      Map<String, dynamic>.from(map['coordinates']),
    ),
    timezone: TimezoneModel.fromMap(Map<String, dynamic>.from(map['timezone'])),
  );
}
