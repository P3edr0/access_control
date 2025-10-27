class TimezoneDto {
  final String offset;
  final String description;

  TimezoneDto({required this.offset, required this.description});

  factory TimezoneDto.fromJson(Map<String, dynamic> json) =>
      TimezoneDto(offset: json['offset'], description: json['description']);
}
