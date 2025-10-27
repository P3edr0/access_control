class IdModel {
  final String? name;
  final String? value;

  IdModel({this.name, this.value});

  Map<String, dynamic> toMap() => {'name': name, 'value': value};

  factory IdModel.fromMap(Map<String, dynamic> map) =>
      IdModel(name: map['name'] as String, value: map['value'] as String?);
}
