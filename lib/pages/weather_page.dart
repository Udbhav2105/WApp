import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/api/weather%20api.dart';
import 'package:weather_app/components/fortnight_list.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherData data;
  bool isLoading = true;

  void setupWeatherPage() async {
    data = ModalRoute.of(context)?.settings.arguments as WeatherData;
    await data.getCurrWeather();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setupWeatherPage();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  SafeArea(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                          color: Color(0xFFcde1fc).withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(data.city,
                                    style: GoogleFonts.montserrat(
                                        color: const Color(0xFF3f6096),
                                        fontSize: 40,
                                        fontWeight: FontWeight.w400)),
                                const Text("Today 00 : 32",
                                    style: TextStyle(
                                      color: Color(0xFF3f6096),
                                      fontSize: 17,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.temp.toString(),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 100,
                                      color: const Color(0xFF3f6096),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    "\u00B0",
                                    style: TextStyle(
                                      fontSize: 80,
                                      color: Color(0xFF3f6096),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 28, 0),
                                child: Text(
                                  data.description,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: const Color(0xFF3f6096),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(Icons.cloud,
                                          size: 25, color: Color(0xFF3f6096)),
                                      const SizedBox(height: 8),
                                      Text("Pressure",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: const Color(0xFF3f6096))),
                                      Text("${data.pressure} hPa",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(Icons.opacity,
                                          size: 25, color: Color(0xFF3f6096)),
                                      const SizedBox(height: 8),
                                      Text("Humidity",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: const Color(0xFF3f6096))),
                                      Text("${data.humidity}%",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(Icons.air,
                                          size: 25, color: Color(0xFF3f6096)),
                                      const SizedBox(height: 8),
                                      Text("Wind Speed",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: const Color(0xFF3f6096))),
                                      Text("${data.wind}km/h",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ],
                              ),
                              // Image.network(
                              //     "http://openweathermap.org/img/wn/${data.icon}@2x.png")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(0.1),
                    ),
                    child: Text("Next 15 Days",style:
                      GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3f6096),
                      ),),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.fortNight!['data'].length,
                      itemBuilder: (context, index) {
                        final dayWeather = data.fortNight!['data'][index];

                        final String date =
                            dayWeather['datetime'] ?? 'Unknown date';

                        final double temp = (dayWeather['temp'] is int)
                            ? (dayWeather['temp'] as int).toDouble()
                            : dayWeather['temp'] ?? 0.0;

                        final String iconCode =
                            dayWeather['weather']['icon'] ?? 'default';
                        final String iconUrl =
                            'https://www.weatherbit.io/static/img/icons/$iconCode.png';

                        return FortnightList(
                          date: date,
                          iconUrl: iconUrl,
                          temp: temp,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
