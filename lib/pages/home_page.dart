import 'package:flutter/material.dart';
import 'package:weather_app/widgets/addition_widget.dart';
import 'package:weather_app/service/api_info.dart';
import 'package:weather_app/service/calculation_service.dart';
import 'package:weather_app/widgets/main_widget_card.dart';
import 'package:weather_app/pages/days_page_details.dart';
import 'package:weather_app/widgets/prediction_widget.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> weatherFuture;
  final myapi = ApiInfo();
  @override
  void initState() {
    super.initState();
    weatherFuture = myapi.weather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Weather App'),
        centerTitle: true,
        toolbarHeight: 50,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weatherFuture = myapi.weather();
              });
            },
            icon:const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong. Please try again later.',
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          }
          final data = snapshot.data!;
          final double currentTemp = data['current']['temperature_2m'];
          final String currentWeather = getWeatherName(
            data['current']['weather_code'],
          );
          final IconData currentIcon = getIcon(data['current']['weather_code']);
          final String currentDate = data['current']['time'];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DaysPageDetails(data: data, index: 0);
                        },
                      ),
                    );
                  },
                  child: MainWidgetCard(
                    temp: currentTemp.toString(),
                    icon: currentIcon,
                    weather: currentWeather,
                    date: currentDate,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Weekly Forecast: ',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data['daily'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: GestureDetector(
                        child: PredictionWidget(
                          date: DateFormat.EEEE().format(
                            DateTime.parse(data['daily']['time'][index + 1]),
                          ),
                          icon: getIcon(
                            data['daily']['weather_code'][index + 1],
                          ),
                          temp:
                              '${data['daily']['temperature_2m_min'][index + 1]}/${data['daily']['temperature_2m_max'][index + 1]}',
                          weather: getWeatherName(
                            data['daily']['weather_code'][index + 1],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DaysPageDetails(
                                  data: data,
                                  index: index + 1,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Additional Information: ',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionWidget(
                    icon: Icons.water_drop,
                    name: 'Humidity',
                    number:
                        '${data['current']['relative_humidity_2m'].toString()}${data['current_units']['relative_humidity_2m']}',
                  ),
                  AdditionWidget(
                    icon: Icons.air_outlined,
                    name: 'Wind Speed',
                    number:
                        '${data['current']['wind_speed_10m'].toString()}${data['current_units']['wind_speed_10m']}',
                  ),
                  AdditionWidget(
                    icon: Icons.compress,
                    name: 'Pressure',
                    number:
                        '${data['current']['surface_pressure'].toString()}${data['current_units']['surface_pressure']}',
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
