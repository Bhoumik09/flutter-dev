import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/screens/auth_screens.dart';
import 'package:amazon/features/auth/screens/init_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       colorScheme: const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        scaffoldBackgroundColor: GlobalVariables.greyBackgroundCOlor,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
          backgroundColor:GlobalVariables.secondaryColor,
          foregroundColor: GlobalVariables.backgroundColor
          
        ))
      ),
      home:const  InitPage()
    );
  }
}
