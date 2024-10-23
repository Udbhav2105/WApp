// THIS IS THE MAIN CARD OF THE WEATHER PAGE
import 'package:flutter/material.dart';
import 'package:weather_app/services/app_color.dart';
import 'package:weather_app/services/weather_api.dart';
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
          color:AppColor.secondaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded( // To ensure the text occupies available space
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                    child:
                    Text(
                      data.city.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        color: AppColor.primaryColor,
                        fontSize: 38,
                        fontWeight: FontWeight.w400,
                      ),
                      // No need for overflow: TextOverflow.ellipsis since it's scrollable now
                    ),
                  ),
                ),
                const Text(
                  "Today",
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          )

,
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.temp.toStringAsFixed(1),
                    style: GoogleFonts.montserrat(
                      fontSize: 90,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    // "\u00B0 C"
                    "\u00B0",
                    style: TextStyle(
                      fontSize: 80,
                      color:AppColor.primaryColor,
                    ),
                  ),
                  Text(
                    "C",
                    style: GoogleFonts.montserrat(
                      fontSize: 80,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  data.description,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: AppColor.primaryColor,
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
                          size: 25, color:AppColor.primaryColor),
                      const SizedBox(height: 8),
                      Text("Pressure",
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: AppColor.primaryColor)),
                      Text("${data.pressure} hPa",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.black)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.opacity,
                          size: 25, color:AppColor.primaryColor),
                      const SizedBox(height: 8),
                      Text("Humidity",
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: AppColor.primaryColor)),
                      Text("${data.humidity}%",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.black)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.air, size: 25, color:AppColor.primaryColor),
                      const SizedBox(height: 8),
                      Text("Wind Speed",
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: AppColor.primaryColor)),
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
