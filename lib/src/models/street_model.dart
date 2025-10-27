class StreetModel {
  final int number;
  final String name;

  StreetModel({required this.number, required this.name});

  factory StreetModel.fromJson(Map<String, dynamic> json) =>
      StreetModel(number: json['number'], name: json['name']);

  Map<String, dynamic> toJson() => {'number': number, 'name': name};
}
