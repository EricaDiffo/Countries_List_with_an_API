import 'package:flutter/material.dart';
import 'package:rest_countries/Model_service/country.dart';
import 'package:rest_countries/Model_service/data_service.dart';
import 'package:rest_countries/pages/countriesDetails.dart';

class Countrieslist extends StatefulWidget {
  const Countrieslist({super.key});
  @override
  State<Countrieslist> createState() => _CountrieslistState();
}

class _CountrieslistState extends State<Countrieslist> {
  late Future<List<Country>> futureCountries;
  String search = '';
  int currentPage = 0; //l'index
  final int countriesPerPage = 10;

  @override
  void initState() {
    super.initState();
    futureCountries = fetchCountry();
  }

  void updateSearch(String query) {
    setState(() {
      //met a jr l'ett et declenche un nouveau rendu
      search = query.toLowerCase();
      currentPage = 0; // Réinitialiser à la première page lors d'une nouvelle recherche
    });
  }

  void nextPage() {
    setState(() {
      currentPage++;
    });
  }

  void previousPage() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All the countries in the world',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: updateSearch, //ecouteur pour mettre a jr la var search
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Country>>(
              future: futureCountries,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No countries found'));
                } else {
                  List<Country> countries = snapshot.data!;
                  List<Country> filteredCountries = countries.where((country) {
                    //filtrage des pays
                    return country.name.toLowerCase().contains(search);
                  }).toList();
                  filteredCountries.sort((a, b) => a.name.compareTo(b.name));

                  int start = currentPage * countriesPerPage; //calcule le 1 index pour la pageActuel
                  int end = start + countriesPerPage;
                  end = end > filteredCountries.length  //s'assurer de ne pas depasser la taille de la liste
                      ? filteredCountries.length
                      : end;
                  List<Country> numberOfCountries =          //sousliste des pays a afficher
                      filteredCountries.sublist(start, end);
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                        itemCount: numberOfCountries.length,
                        itemBuilder: (context, index) {
                          var country = numberOfCountries[index];
                          return Card(
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(country.flag),
                              ),
                              title: Text(country.name,
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetail(
                                        countryId: country.alpha3Code),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                       ),
                      ),

                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentPage > 0)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 58, 59, 59),
                              ),
                              onPressed: previousPage,
                              child: const Text('Previous', style: TextStyle(color: Colors.white),),
                            ),
                          if (end < filteredCountries.length)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                              onPressed: nextPage,
                              child: const Text('Next Page', style: TextStyle(color: Colors.white),),
                            ),
                        ]
                      )    

                    ],
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
