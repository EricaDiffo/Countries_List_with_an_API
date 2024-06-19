
class Country {
  final String name;
  final String flag;
  final String capital;
  final String region;
  final List<String> languages;
  final String alpha3Code;

  Country({
    required this.name,
    required this.flag,
    required this.capital,
    required this.region,
    required this.languages,
    required this.alpha3Code,
  });

  factory Country.fromJson(Map<String, dynamic> json) {

    var languagesJson = json['languages'] as Map<String, dynamic>? ?? {};
    var languagesList = languagesJson.values.cast<String>().toList();
    return Country(
      name: json['name']['common'],
      flag: json['flags']['png'],
      capital: json['capital'] != null ? json['capital'][0] : 'No capital',
      region: json['region'],
      languages: languagesList,
      alpha3Code: json['cca3'],
    );
  }
}
