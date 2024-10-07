import 'package:flutter/material.dart';

class WeatherForecastCard extends StatelessWidget {
  const WeatherForecastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          children: [
            Text(
              '03:30',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Icon(
              Icons.cloud,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              "300.14",
            )
          ],
        ),
      ),
    );
  }
}
