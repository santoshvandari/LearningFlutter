import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/additionalinfoitem.dart';
import 'package:weatherapp/iconAsPerWeather.dart';
import 'package:weatherapp/weatherforcastitem.dart';

class WeatherAppHome extends StatefulWidget {
  const WeatherAppHome({super.key});

  @override
  State<WeatherAppHome> createState() => _WeatherAppHomeState();
}

class _WeatherAppHomeState extends State<WeatherAppHome> {
  Future<Map<String, dynamic>> getWeatherInfo() async {
    String url1 =
        "https://api.openweathermap.org/data/2.5/weather?q=Biratnagar&units=metric&APPID=d3db3a438bffd1f64b93c92253c8e4b7";
    String url2 =
        "https://api.openweathermap.org/data/2.5/forecast?q=Biratnagar&units=metric&APPID=d3db3a438bffd1f64b93c92253c8e4b7";
    try {
      final res1 = await http.get(Uri.parse(url1));
      final res2 = await http.get(Uri.parse(url2));
      final temp1 = jsonDecode(res1.body);
      final temp2 = jsonDecode(res2.body);
      if (temp1["cod"] != 200) {
        throw "An Unexpected Error Occured!!!";
      }
      if (temp2["cod"] != "200") {
        throw "An Unexpected Error Occured!!!";
      }
      Map<String, dynamic> data = {...temp1, ...temp2};
      debugPrint("Working");
      debugPrint(data.toString());
      return data;
    } catch (ex) {
      throw "$ex";
      // throw "An Unexpected Error Occured!!!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // debugPrint("Testing ");
              setState(() {
                getWeatherInfo();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getWeatherInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            );
          }

          final data = snapshot.data!;
          final currentTemp = data["main"]["temp"];
          final currentWeatherStatus = data["weather"][0]['main'];
          final currentIconStatus = data["weather"][0]["main"];
          IconData icon = getIcon(currentIconStatus);
          final currentHumidity = data["main"]["humidity"];
          final currentPressure = data["main"]["pressure"];
          final currentWind = data["wind"]["speed"];
          final forecastWeather = data['list'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  " $currentTemp °c",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                  icon,
                                  size: 40,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "$currentWeatherStatus",
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        20,
                        (index) {
                          final time = DateFormat('HH:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  forecastWeather[index]["dt"] * 1000));
                          return WeatherForecastCard(
                              icon: getIcon(
                                  forecastWeather[index]['weather'][0]['main']),
                              time: "$time UTC",
                              value:
                                  "${forecastWeather[index]['main']['temp']}");
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInformation(
                          icon: Icons.water_drop,
                          label: "Humidity",
                          value: "$currentHumidity %"),
                      AdditionalInformation(
                          icon: Icons.air,
                          label: "Wind Speed",
                          value: "$currentWind m/s"),
                      AdditionalInformation(
                          icon: Icons.beach_access,
                          label: "Pressure",
                          value: "$currentPressure hPa"),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
