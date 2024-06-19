import 'package:flutter/material.dart';
import 'package:rest_countries/pages/countriesList.dart';
class Countries extends StatefulWidget {
  const Countries({super.key});

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.location_pin,size: 60),
              const SizedBox(height: 20),
              const Text('Choose Your Country', style:
                TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please select a country to have a better experience',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search a Country',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const Countrieslist()));
                    },
                  )
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
