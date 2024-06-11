import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:const  WeatherScreen(),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   appBarTheme: const AppBarTheme(backgroundColor: Colors.red),
      // )
      theme:ThemeData.dark().copyWith(cardColor: const Color.fromARGB(255, 228, 224, 224)) ,
    );
  }
}