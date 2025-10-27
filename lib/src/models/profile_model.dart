class ProfileModel {
  final String uuid;
  final String username;
  final String password;

  ProfileModel({
    required this.uuid,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
    'uuid': uuid,
    'username': username,
    'password': password,
  };

  factory ProfileModel.fromMap(Map<String, dynamic> map) => ProfileModel(
    uuid: map['uuid'] as String,
    username: map['username'] as String,
    password: map['password'] as String,
  );
}
