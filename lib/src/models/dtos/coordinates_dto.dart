class CoordinatesDto {
  final String latitude;
  final String longitude;

  CoordinatesDto({required this.latitude, required this.longitude});

  factory CoordinatesDto.fromJson(Map<String, dynamic> json) =>
      CoordinatesDto(latitude: json['latitude'], longitude: json['longitude']);
}
