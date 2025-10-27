import 'dart:convert';

import 'package:access_control/src/models/address_model.dart';
import 'package:access_control/src/models/id_model.dart';
import 'package:access_control/src/models/profile_model.dart';
import 'package:access_control/src/models/registry_model.dart';

class GuestModel {
  final int? id;
  final String gender;
  final String name;
  final AddressModel address;
  final String email;
  final ProfileModel profile;
  final RegistryModel dob;
  final RegistryModel registry;
  final String phone;
  final String cell;
  final IdModel systemId;
  final String picture;
  final String nat;

  GuestModel({
    this.id,
    required this.gender,
    required this.name,
    required this.address,
    required this.email,
    required this.profile,
    required this.dob,
    required this.registry,
    required this.phone,
    required this.cell,
    required this.systemId,
    required this.picture,
    required this.nat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gender': gender,
      'name': name,
      'address': jsonEncode(address.toMap()),
      'email': email,
      'profile': jsonEncode(profile.toMap()),
      'dob': jsonEncode(dob.toMap()),
      'registry': jsonEncode(registry.toMap()),
      'phone': phone,
      'cell': cell,
      'id_model': jsonEncode(systemId.toMap()),
      'picture': picture,
      'nat': nat,
    };
  }

  factory GuestModel.fromMap(Map<String, dynamic> map) {
    return GuestModel(
      id: map['id'] as int?,
      gender: map['gender'] as String,
      name: map['name'] as String,
      address: AddressModel.fromMap(jsonDecode(map['address'] as String)),
      email: map['email'] as String,
      profile: ProfileModel.fromMap(jsonDecode(map['profile'] as String)),
      dob: RegistryModel.fromMap(jsonDecode(map['dob'] as String)),
      registry: RegistryModel.fromMap(jsonDecode(map['registry'] as String)),
      phone: map['phone'] as String,
      cell: map['cell'] as String,
      systemId: IdModel.fromMap(jsonDecode(map['id_model'] as String)),
      picture: map['picture'] as String,
      nat: map['nat'] as String,
    );
  }
  GuestModel copyWith({
    int? id,
    String? gender,
    String? name,
    AddressModel? address,
    String? email,
    ProfileModel? profile,
    RegistryModel? dob,
    RegistryModel? registry,
    String? phone,
    String? cell,
    IdModel? systemId,
    String? picture,
    String? nat,
  }) {
    return GuestModel(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      profile: profile ?? this.profile,
      dob: dob ?? this.dob,
      registry: registry ?? this.registry,
      phone: phone ?? this.phone,
      cell: cell ?? this.cell,
      systemId: systemId ?? this.systemId,
      picture: picture ?? this.picture,
      nat: nat ?? this.nat,
    );
  }
}
