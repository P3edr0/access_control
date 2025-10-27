class CoordinatesModel {
  final String latitude;
  final String longitude;

  CoordinatesModel({required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() => {
    'latitude': latitude,
    'longitude': longitude,
  };

  factory CoordinatesModel.fromMap(Map<String, dynamic> map) =>
      CoordinatesModel(
        latitude: map['latitude'] as String,
        longitude: map['longitude'] as String,
      );
}
