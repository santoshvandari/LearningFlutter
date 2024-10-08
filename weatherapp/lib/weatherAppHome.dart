import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/additionalinfoitem.dart';
import 'package:weatherapp/iconAsPerWeather.dart';
import 'package:weatherapp/weather_main_card.dart';
import 'package:weatherapp/weatherforcastitem.dart';

class WeatherAppHome extends StatefulWidget {
  const WeatherAppHome({super.key});

  @override
  State<WeatherAppHome> createState() => _WeatherAppHomeState();
}

class _WeatherAppHomeState extends State<WeatherAppHome> {
  Future<Map<String, dynamic>> getWeatherInfo() async {
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=Nepal&units=metric&APPID=d3db3a438bffd1f64b93c92253c8e4b7";
    try {
      final res = await http.get(Uri.parse(url));
      final data = jsonDecode(res.body);
      if (data["cod"] != "200") {
        throw "An Unexpected Error Occured!!!";
      }
      return data;
    } catch (ex) {
      // throw "$ex";
      throw "An Unexpected Error Occured!!!";
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
              setState(() {
                getWeatherInfo();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Column(
              children: [
                Text(
                  "Nepal",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: getWeatherInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    heightFactor: 5,
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
                final currentTemp = data['list'][0]["main"]["temp"];
                final currentWeatherStatus =
                    data['list'][0]["weather"][0]['main'];
                IconData icon = getIcon(currentWeatherStatus);
                final currentHumidity = data['list'][0]["main"]["humidity"];
                final currentPressure = data['list'][0]["main"]["pressure"];
                final currentWind = data['list'][0]["wind"]["speed"];
                final forecastWeather = data['list'];

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Center(
                        //   child: Text(
                        //     "Additional Info",
                        //     style: TextStyle(
                        //         fontSize: 24, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        MainCard(
                            currentTemp: currentTemp,
                            icon: icon,
                            currentWeatherStatus: currentWeatherStatus),
                        const SizedBox(height: 20),
                        const Text(
                          "Weather Forecast",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: List.generate(
                        //       20,
                        //       (index) {
                        //         final time = DateFormat('HH:mm').format(
                        //             DateTime.fromMillisecondsSinceEpoch(
                        //                 forecastWeather[index]["dt"] * 1000));
                        //         return WeatherForecastCard(
                        //             icon: getIcon(forecastWeather[index]
                        //                 ['weather'][0]['main']),
                        //             time: "$time UTC",
                        //             value:
                        //                 "${forecastWeather[index]['main']['temp']}");
                        //       },
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              final weather = forecastWeather[index + 1];
                              final time = DateFormat('HH:mm')
                                  .format(DateTime.parse(weather["dt_txt"]));
                              final weatherstatus =
                                  weather['weather'][0]['main'];
                              return WeatherForecastCard(
                                  icon: getIcon(weatherstatus),
                                  time: "$time UTC",
                                  value: "${weather['main']['temp']}",
                                  status: "${weatherstatus}");
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Additional Information",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
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
                                icon: Icons.thermostat,
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
          ],
        ),
      ),
    );
  }
}
