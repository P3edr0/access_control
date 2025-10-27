class TimezoneModel {
  final String offset;
  final String description;

  TimezoneModel({required this.offset, required this.description});

  Map<String, dynamic> toMap() => {
    'offset': offset,
    'description': description,
  };

  factory TimezoneModel.fromMap(Map<String, dynamic> map) => TimezoneModel(
    offset: map['offset'] as String,
    description: map['description'] as String,
  );
}
