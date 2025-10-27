class RegistryModel {
  final DateTime date;
  final int age;

  RegistryModel({required this.date, required this.age});

  Map<String, dynamic> toMap() => {'date': date.toIso8601String(), 'age': age};

  factory RegistryModel.fromMap(Map<String, dynamic> map) => RegistryModel(
    date: DateTime.parse(map['date'] as String),
    age: map['age'] as int,
  );
}
