class RegistryDto {
  final String date;
  final int age;

  RegistryDto({required this.date, required this.age});

  factory RegistryDto.fromJson(Map<String, dynamic> json) =>
      RegistryDto(date: json['date'], age: json['age']);
}
