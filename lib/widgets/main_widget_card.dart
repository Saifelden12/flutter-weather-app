import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainWidgetCard extends StatelessWidget {
  final String temp;
  final IconData icon;
  final String weather;
  final String date;
  const MainWidgetCard({
    super.key,
    required this.temp,
    required this.icon,
    required this.weather,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          surfaceTintColor: Colors.transparent,
          elevation: 4,
          color:const Color.fromRGBO(90, 90, 90, 0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  DateFormat.EEEE().format(DateTime.parse(date)),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$temp°C',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Icon(icon, size: 64),
                const SizedBox(height: 10),
                Text(
                  weather,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
