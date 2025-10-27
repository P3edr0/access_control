class StreetDto {
  final int number;
  final String name;

  StreetDto({required this.number, required this.name});

  factory StreetDto.fromJson(Map<String, dynamic> json) =>
      StreetDto(number: json['number'], name: json['name']);
}
