import 'package:access_control/utils/formatters/empty_value_formatter.dart';

class IdDto {
  final String name;
  final String value;

  IdDto({required this.name, required this.value});

  factory IdDto.fromJson(Map<String, dynamic> json) {
    final formatter = EmptyValueFormatter();
    final idName = formatter(json['name']);
    final idValue = formatter(json['value']);
    return IdDto(name: idName, value: idValue);
  }
}
