import 'package:access_control/src/models/address_model.dart';
import 'package:access_control/src/models/coordinates_model.dart';
import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/src/models/id_model.dart';
import 'package:access_control/src/models/profile_model.dart';
import 'package:access_control/src/models/registry_model.dart';
import 'package:access_control/src/models/street_model.dart';
import 'package:access_control/src/models/timezone_model.dart';

import 'address_dto.dart';
import 'birthday_dto.dart';
import 'id_dto.dart';
import 'name_dto.dart';
import 'picture_dto.dart';
import 'profile_dto.dart';
import 'registry_dto.dart';

class GuestDto {
  final String gender;
  final NameDto name;
  final AddressDto address;
  final String email;
  final ProfileDto profile;
  final DobDto dob;
  final RegistryDto registry;
  final String phone;
  final String cell;
  final IdDto id;
  final PictureDto picture;
  final String nat;

  GuestDto({
    required this.gender,
    required this.name,
    required this.address,
    required this.email,
    required this.profile,
    required this.dob,
    required this.registry,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  factory GuestDto.fromJson(Map<String, dynamic> json) => GuestDto(
    gender: json['gender'],
    name: NameDto.fromJson(json['name']),
    address: AddressDto.fromJson(json['location']),
    email: json['email'],
    profile: ProfileDto.fromJson(json['login']),
    dob: DobDto.fromJson(json['dob']),
    registry: RegistryDto.fromJson(json['registered']),
    phone: json['phone'],
    cell: json['cell'],
    id: IdDto.fromJson(json['id']),
    picture: PictureDto.fromJson(json['picture']),
    nat: json['nat'],
  );

  GuestModel toEntity() {
    return GuestModel(
      gender: gender,
      name: '${name.first} ${name.last}',
      address: AddressModel(
        street: StreetModel(
          number: address.street.number,
          name: address.street.name,
        ),
        city: address.city,
        state: address.state,
        country: address.country,
        postcode: address.postcode,
        coordinates: CoordinatesModel(
          latitude: address.coordinates.latitude,
          longitude: address.coordinates.longitude,
        ),
        timezone: TimezoneModel(
          offset: address.timezone.offset,
          description: address.timezone.description,
        ),
      ),
      email: email,
      profile: ProfileModel(
        uuid: profile.uuid,
        username: profile.username,
        password: profile.password,
      ),
      dob: RegistryModel(date: DateTime.parse(dob.date), age: dob.age),
      registry: RegistryModel(
        date: DateTime.parse(registry.date),
        age: registry.age,
      ),
      phone: phone,
      cell: cell,
      systemId: IdModel(name: id.name, value: id.value),
      picture: picture.medium,

      nat: nat,
    );
  }
}
