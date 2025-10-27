class ProfileDto {
  final String uuid;
  final String username;
  final String password;

  ProfileDto({
    required this.uuid,
    required this.username,
    required this.password,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) => ProfileDto(
    uuid: json['uuid'],
    username: json['username'],
    password: json['password'],
  );
}
