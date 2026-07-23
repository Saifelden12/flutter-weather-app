import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiInfo {
  final double latitude = 30.0625;
  final double longitude = 31.25;
  // Cairo's latitude and longitude coordinates. Change these values to your country's or city's coordinates.
  Future<Map<String, dynamic>> weather() async {
    final res = await http.get(
      Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code,surface_pressure&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code,surface_pressure&daily=weather_code,temperature_2m_max,temperature_2m_min,wind_speed_10m_max,surface_pressure_mean&timezone=auto',
      ),
    );

    if (res.statusCode != 200) {
      throw Exception('Something went wrong. Please try again later.');
    }
    final data = jsonDecode(res.body);

    return data;
  }
}
