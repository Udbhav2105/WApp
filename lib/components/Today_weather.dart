import 'package:flutter/material.dart';
import 'package:weather_app/api/weather api.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayWeather extends StatelessWidget {
  const TodayWeather({
    super.key,
    required this.data,
  });

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.cloud,
                          size: 25, color: Color(0xFF3f6096)),
                      const SizedBox(height: 8),
                      Text("Pressure",
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: const Color(0xFF3f6096))),
                      Text("${data.pressure} hPa",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.black)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.opacity,
                          size: 25, color: Color(0xFF3f6096)),
                      const SizedBox(height: 8),
                      Text("Humidity",
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: const Color(0xFF3f6096))),
                      Text("${data.humidity}%",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.black)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.air, size: 25, color: Color(0xFF3f6096)),
                      const SizedBox(height: 8),
                      Text("Wind Speed",
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: const Color(0xFF3f6096))),
                      Text("${data.wind}km/h",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
