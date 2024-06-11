import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/add_info_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weathers_forecast_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    String cityName = "India";

    try {
      final res = await http.get(Uri.parse(
          "http://api.openweathermap.org/data/2.5/forecast?q=$cityName,asia&APPID=a89b8df9d143cf653c8fc227d9146c67"));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data;
      } else {
        throw "Failed to load weather: ${res.statusCode}";
      }
    } catch (e) {
      print('An error occurred: $e');
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(
                    () {}); // Triggers a rebuild to call getCurrentWeather again
              },
              icon: const Icon(Icons.refresh))
        ],
        centerTitle: true,
        title: const Text(
          "Weather app",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          final currData = data['list'][0];
          final currentTemp = currData['main']['temp'];
          final currentWeather = currData['weather'][0]['description'];
          final currentSky = currData['weather'][0]['main'];
          final currHumidity = currData['main']['humidity'];
          final currWind = currData['wind']['speed'];
          final currPressure = currData['main']['pressure'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Card(
                    color: const Color.fromARGB(131, 64, 65, 64),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                "$currentTemp K",
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                currentSky,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: deviceHeight * 0.04),
                const Text(
                  "Weather forecast",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: deviceHeight * .01,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: List.generate(39, (i) {
                //       return HourlyForecastItem(
                //          data['list'][i + 1]['dt_txt'],
                //          ['Clouds', 'Rain'].contains(data['list'][i+1]['weather'][0]['main'])  ? Icons.cloud:Icons.sunny,
                //          data['list'][i + 1]['main']['temp'].toString(),
                //       );
                //     }),
                //   ),
                // ),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return HourlyForecastItem(
                          DateFormat.Hm().format(DateTime.parse(
                              data['list'][index + 1]['dt_txt'])),
                          ['Clouds', 'Rain'].contains(
                                  data['list'][index + 1]['weather'][0]['main'])
                              ? Icons.cloud
                              : Icons.sunny,
                          data['list'][index + 1]['main']['temp'].toString(),
                        );
                      }),
                ),
                SizedBox(height: deviceHeight * .015),
                const Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: deviceHeight * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currHumidity.toString()),
                    AdditionalInfoItem(
                        icon: Icons.air, label: "Wind", value: "$currWind m/s"),
                    AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: currPressure.toString()),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
