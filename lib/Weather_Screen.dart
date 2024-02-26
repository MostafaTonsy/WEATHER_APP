import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_forecast_app/card_additional_info.dart';
import 'package:weather_forecast_app/card_weather_forecast.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class Weather_Screen extends StatefulWidget {
  const Weather_Screen({super.key});

  @override
  State<Weather_Screen> createState() => _Weather_ScreenState();
}

class _Weather_ScreenState extends State<Weather_Screen> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> get_current_weather() async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=London&uk&APPID=c5dc37fd67f1f8eb11304234e74c8113'));
      final data = jsonDecode(res.body);

      if (int.parse(data['cod']) != 200) {
        throw data['message'];
      }
      return data;
      //temp = data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = get_current_weather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 210, 189, 4),
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = get_current_weather();
              });
            },
            icon: const Icon(Icons.refresh),
            color: const Color.fromARGB(255, 129, 0, 0),
          ),
        ],
      ),
      body: FutureBuilder(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final data = snapshot.data!;
            final x = data['list'][0]['main'];
            final currentWeatherTemp = x['temp'];
            final currentHumidity = x['humidity'];
            final currentPressure = x['pressure'];
            final currentWindSpeed = data['list'][0]['wind']['speed'];

            final currentSky = data['list'][0]['weather'][0]['main'];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 140,
                    width: double.infinity,
                    child: Card(
                      color: const Color.fromARGB(255, 15, 1, 54),
                      surfaceTintColor: const Color.fromARGB(255, 15, 1, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  ' ${currentWeatherTemp.toString()}°k',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Icon(
                                    currentSky == 'Rain' ||
                                            currentSky == 'Clouds'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 40),
                                const SizedBox(height: 5),
                                Text(
                                  currentSky,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'HOURLY FORECAST',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 7),
                  SizedBox(
                    height: 135,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          final y = data['list'][index + 1];
                          final sky = y['weather'][0]['main'];
                          final time = DateTime.parse(y['dt_txt']);
                          return card_wf_widget(
                            Icon2: sky == 'Rain' || sky == 'Clouds'
                                ? Icons.cloud
                                : Icons.sunny,
                            time2: DateFormat.Hm().format(time),
                            temp2: '${y['main']['temp'].toString()} °k',
                          );
                        }),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        card_aif_widget(
                            icon: Icons.water_drop_sharp,
                            label: 'HUMIDITY',
                            value: currentHumidity.toString()),
                        card_aif_widget(
                            icon: Icons.wind_power,
                            label: 'WIND SPEED',
                            value: currentWindSpeed.toString()),
                        card_aif_widget(
                            icon: Icons.air_rounded,
                            label: 'PRESSURE',
                            value: currentPressure.toString()),
                      ], //additionalinforamtion row children
                    ),
                  ),
                ], //children
              ),
            );
          }),
    );
  }
}
