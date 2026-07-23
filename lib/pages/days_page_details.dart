import 'package:flutter/material.dart';
import 'package:weather_app/widgets/addition_widget.dart';
import 'package:weather_app/service/calculation_service.dart';
import 'package:weather_app/widgets/main_widget_card.dart';
import 'package:weather_app/widgets/prediction_widget.dart';
import 'package:intl/intl.dart';

class DaysPageDetails extends StatefulWidget {
  final int index;
  final Map<String, dynamic> data;
  const DaysPageDetails({super.key, required this.data, required this.index});

  @override
  State<DaysPageDetails> createState() => _DaysPageDetailsState();
}

class _DaysPageDetailsState extends State<DaysPageDetails> {
  @override
  Widget build(BuildContext context) {
    final double minTemp =
        widget.data['daily']['temperature_2m_min'][widget.index];
    final double maxTemp =
        widget.data['daily']['temperature_2m_max'][widget.index];
    final String date = widget.data['daily']['time'][widget.index];
    final int code = widget.data['daily']['weather_code'][widget.index];
    final double windSpeed =
        widget.data['daily']['wind_speed_10m_max'][widget.index];
    final double pressure =
        widget.data['daily']['surface_pressure_mean'][widget.index];
    return Scaffold(
      appBar: AppBar(title: Text(date), centerTitle: true, toolbarHeight: 50),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainWidgetCard(
            temp: '$minTemp/$maxTemp',
            icon: getIcon(code),
            weather: getWeatherName(code),
            date: date,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Hourly Forecast: ',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (widget.data['hourly']['time'].length / 7).toInt(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: PredictionWidget(
                    date: DateFormat.jm().format(
                      DateTime.parse(
                        widget.data['hourly']['time'][widget.index * 24 +
                            index],
                      ),
                    ),
                    icon: getIcon(
                      widget.data['hourly']['weather_code'][widget.index * 24 +
                          index],
                    ),
                    temp: widget
                        .data['hourly']['temperature_2m'][widget.index * 24 +
                            index]
                        .toString(),
                    weather: getWeatherName(
                      widget.data['hourly']['weather_code'][widget.index * 24 +
                          index],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Additional Information: ',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AdditionWidget(
                icon: Icons.water_drop,
                name: 'Average\nHumidity',
                number:
                    '${calculateAvgHumidity(widget.data['hourly']['relative_humidity_2m'], widget.index).toStringAsFixed(2)}${widget.data['current_units']['relative_humidity_2m']}',
              ),
              AdditionWidget(
                icon: Icons.air_outlined,
                name: 'Wind Speed',
                number:
                    '${windSpeed.toString()}${widget.data['current_units']['wind_speed_10m']}',
              ),
              AdditionWidget(
                icon: Icons.compress,
                name: 'Pressure',
                number:
                    '${pressure.toString()}${widget.data['current_units']['surface_pressure']}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
