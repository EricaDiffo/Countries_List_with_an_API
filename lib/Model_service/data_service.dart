import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_countries/Model_service/country.dart';

Future<List<Country>> fetchCountry() async {
  final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    //return jsonResponse.map((country) => Country.fromJson(country)).toList();
    return jsonResponse.map((country) {
      var value = Country.fromJson(country);
      return value;
    }).toList();
  } else {
    throw Exception('Failed to load countries'); 
  }
}

Future<Country> fetchCountryById(String id) async {
  final response = await http.get(Uri.parse('https://restcountries.com/v3.1/alpha/$id'));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    return Country.fromJson(jsonResponse[0]);
  } else {
    print('Failed to load country: ${response.statusCode}');
    throw Exception('Failed to load country');
  }
}

