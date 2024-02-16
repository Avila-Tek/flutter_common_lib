class Country {
  final String name;
  final String code;

  const Country({required this.name, required this.code});

  static const Country empty = Country(name: '', code: '');
}
