import 'package:flutter/material.dart';

String getWeatherName(int x) {
  switch (x) {
    case 0:
      return "Sunny";
    case 1:
    case 2:
      return "Partly Cloudy";
    case 3:
      return "Cloudy";
    case 45:
    case 48:
      return "Fog";
    case 51:
    case 53:
    case 55:
      return "Drizzle";
    case 61:
    case 63:
    case 65:
      return "Rain";
    case 71:
    case 73:
    case 75:
      return "Snow";
    case 95:
      return "Thunderstorm";
    default:
      return "Unknown";
  }
}

IconData getIcon(int x) {
  switch (x) {
    case 0:
      return Icons.wb_sunny;
    case 1:
    case 2:
      return Icons.cloud_queue;

    case 3:
      return Icons.cloud;

    case 45:
    case 48:
      return Icons.foggy;

    case 51:
    case 53:
    case 55:
      return Icons.grain;

    case 61:
    case 63:
    case 65:
      return Icons.umbrella;

    case 71:
    case 73:
    case 75:
      return Icons.ac_unit;

    case 95:
      return Icons.thunderstorm;

    default:
      return Icons.help_outline;
  }
}

double calculateAvgHumidity(List<dynamic> humiditylist, int index) {
  double sum = 0;
  for (int i = 0; i < 24; i++) {
    sum += humiditylist[index * 24 + i];
  }
  double humidity = sum / 24;
  return humidity;
}
