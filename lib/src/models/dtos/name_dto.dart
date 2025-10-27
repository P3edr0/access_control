class NameDto {
  final String title;
  final String first;
  final String last;

  NameDto({required this.title, required this.first, required this.last});

  factory NameDto.fromJson(Map<String, dynamic> json) =>
      NameDto(title: json['title'], first: json['first'], last: json['last']);
}
