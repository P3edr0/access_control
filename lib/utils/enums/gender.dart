enum Gender {
  male,
  female;

  bool get isMale => this == male;
  bool get isFemale => this == female;

  static Gender translate(String gender) {
    switch (gender) {
      case 'female':
        return female;

      default:
        return male;
    }
  }
}
