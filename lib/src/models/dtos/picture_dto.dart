class PictureDto {
  final String large;
  final String medium;
  final String thumbnail;

  PictureDto({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory PictureDto.fromJson(Map<String, dynamic> json) => PictureDto(
    large: json['large'],
    medium: json['medium'],
    thumbnail: json['thumbnail'],
  );
}
