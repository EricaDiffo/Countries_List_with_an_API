import 'package:flutter/material.dart';
import 'package:rest_countries/Model_service/country.dart';
import 'package:rest_countries/Model_service/data_service.dart';

class CountryDetail extends StatelessWidget {
  final String countryId;

  CountryDetail({required this.countryId}){
    print('Country ID: $countryId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder<Country>(
        future: fetchCountryById(countryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),) ;
          } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
          return const Text('No country found');
          } else{
            var country = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
              title: Text(country.name),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Image.network(country.flag),
                    ),
                  ),
                const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                    child: Text(
                      'Name: ${country.name}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                const SizedBox(height: 10),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                  child: Text(
                    'Capital: ${country.capital}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Text(
                    'Region: ${country.region}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 10),
                Container(
                    decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Text(
                    'Languages: ${country.languages.join(", ")}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ],
                ),
              ),
            );
            }
          }
      ),
    );
  }
}