class DobDto {
  final String date;
  final int age;

  DobDto({required this.date, required this.age});

  factory DobDto.fromJson(Map<String, dynamic> json) =>
      DobDto(date: json['date'], age: json['age']);
}
