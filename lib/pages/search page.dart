import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weather_app/services/weather%20api.dart';
import 'package:weather_app/components/inp.dart';
import 'package:weather_app/components/list_of_locs.dart';

class SearchLoc extends StatefulWidget {
  const SearchLoc({super.key});

  @override
  State<SearchLoc> createState() => _SearchLocState();
}

class _SearchLocState extends State<SearchLoc> {
  final TextEditingController loc = TextEditingController();
  List<WeatherData> cities = [];

  void addCity() async {
    if (loc.text.isNotEmpty) {
      WeatherData weatherData = WeatherData(loc.text);
      bool locationFound = await weatherData.getLonLat();
      await weatherData.getFiveDayForecast();
      await weatherData.hourlyData();
      if (locationFound) {
        setState(() {
          cities.add(weatherData);
          loc.clear();
        });
      } else {
        print('Location not found');
      }
    }
  }

  void removeCity(int index) {
    setState(() {
      cities.removeAt(index);
    });
  }

  Future<void> navigateToWeatherPage(int index) async {
    final result = await Navigator.pushNamed(
      context,
      '/weatherPage',
      arguments: cities[index],
    );

    if (result != null && result is List<WeatherData>) {
      setState(() {
        cities = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputBox(inputText: "Location", controller: loc),
              SizedBox(
                width: size,
                child: ElevatedButton(
                  onPressed: addCity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFcde1fc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: Color(0xFF3f6096),
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () => navigateToWeatherPage(index),
                        child: LocationList(
                          location: cities[index].city[0].toUpperCase() +
                              cities[index].city.substring(1).toLowerCase(),
                          onRemove: () => removeCity(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
