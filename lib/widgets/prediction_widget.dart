import 'package:flutter/material.dart';

class PredictionWidget extends StatelessWidget {
  final String date;
  final String temp;
  final IconData icon;
  final String weather;
  const PredictionWidget({
    super.key,
    required this.date,
    required this.icon,
    required this.temp,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromRGBO(90, 90, 90, 0.8),
        border: Border.all(width: 2, color: const Color.fromRGBO(1, 1, 45, 1)),
      ),

      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(date, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 5),
          Text('$temp°C', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 5),
          Icon(icon, size: 30),
          const SizedBox(height: 5),
          Center(child: Text(weather, style: TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
