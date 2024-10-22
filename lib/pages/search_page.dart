import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/app_color.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/components/inp.dart';
import 'package:weather_app/components/list_of_locs.dart';
import 'package:weather_app/services/auth.dart';

class SearchLoc extends StatefulWidget {
  const SearchLoc({super.key});

  @override
  State<SearchLoc> createState() => _SearchLocState();
}

class _SearchLocState extends State<SearchLoc> {
  final TextEditingController loc = TextEditingController();
  List<Map<String, dynamic>> cities = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices _auth = AuthServices();

  @override
  void initState() {
    super.initState();
    fetchLocationFromFirestore();
  }

// THIS FETCHES DATA FROM FIREBASE
  Future<void> fetchLocationFromFirestore() async {
    String? userId = _auth.currentUser?.uid;

    if (userId != null) {
      DocumentSnapshot snapshot =
          await _firestore.collection('cities').doc(userId).get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        var locations = data['loc'] as List<dynamic>;
        setState(() {
          cities = locations.map((locationData) {
            return {
              'location': locationData['location'],
              'coordinates': {
                'lat': locationData['coordinates']['lat'],
                'lon': locationData['coordinates']['lon']
              }
            };
          }).toList();
        });
      }
    }
  }

  // THIS ADDS LOCATION TO FIREBASE
  void addCity() async {
    print('trying to add');
    if (loc.text.isNotEmpty) {
      WeatherData weatherData = WeatherData(loc.text);
      bool locationFound = await weatherData.getLonLat();
      if (locationFound) {
        String? userId = _auth.currentUser?.uid;
        if (userId != null) {
          Map<String, dynamic> newLocation = {
            'location': loc.text,
            'coordinates': {
              'lat': weatherData.latitude,
              'lon': weatherData.longitude
            }
          };
          await _firestore.collection('cities').doc(userId).update({
            'loc': FieldValue.arrayUnion([newLocation])
          }).then((_) {
            print("Location added");
          }).catchError((error) async {
            await _firestore.collection('cities').doc(userId).set({
              'loc': [newLocation]
            });
          });
          setState(() {
            cities.add(newLocation);
            loc.clear();
          });
        } else {
          print('Location not found');
        }
      }
    }
  }

// THIS REMOVES LOCATION FROM FIREBASE
  void removeCity(int index) async {
    String? userId = _auth.currentUser?.uid;
    if (userId != null) {
      Map<String, dynamic> cityToRemoved = cities[index];
      await _firestore.collection('cities').doc(userId).update({
        'loc': FieldValue.arrayRemove([cityToRemoved])
      }).then((_) {
        print("Location removed successfully");
      }).catchError((error) {
        print("Failed to remove: $error");
      });

      setState(() {
        cities.removeAt(index);
      });
    } else {
      print("User ID not found");
    }
  }


  // Future<void> navigateToWeatherPage(int index) async {
  //   final result = await Navigator.pushNamed(
  //     context,
  //     '/weatherPage',
  //     arguments: cities[index],
  //   );
  //
  //   if (result != null && result is List<WeatherData>) {
  //     setState(() {
  //       cities = result.cast<Map<String, dynamic>>();
  //     });
  //   }
  // }

  void signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Search Locations',
          style: TextStyle(
            color: Colors.black54,
            letterSpacing: .2,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: signOut,
          ),
        ],
      ),
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
                    backgroundColor: AppColor.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: AppColor.primaryColor,
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
                        onTap: () => Navigator.pushNamed(
                            context, '/weatherPage',
                            arguments: cities[index]),
                        // onTap: () => navigateToWeatherPage(index),
                        child: LocationList(
                          location: cities[index]['location'].toUpperCase(),
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
