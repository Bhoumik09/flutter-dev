import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/cart_provider.dart';
import 'package:shop_flutter/global_varibles.dart';
import 'package:shop_flutter/home_page.dart';
import 'package:shop_flutter/product_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  ///Provider -> Read only value 
  ///chnage notifier provider -> chnage the value and notify the widget listening to it 
  ///future provider 
  ///Stream notifier provider 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // the thing we return hee would be availabe to all the widegot 
      create: (context)=>CartProvider(),
      child: MaterialApp(
        title: "shopping mall app",
        debugShowCheckedModeBanner: false,
        home:  const HomePage(),
        theme: ThemeData(
            useMaterial3: true,
            inputDecorationTheme: const InputDecorationTheme(
              prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            appBarTheme:const AppBarTheme(titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            textTheme: const TextTheme(
              
                titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
      ),
    );
  }
}
