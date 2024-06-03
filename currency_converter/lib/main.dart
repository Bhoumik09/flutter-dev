import 'package:currency_converter/currecy_conv_mat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  // default line given by flutter to run  the app 
  runApp(const MyApp());
  //here .ltr worked becuase thextDirection was a enum 
}
// Widegt is the building block of the interface 

// Types of widgit 
// 1)stateless ->data is immutale.
// 2)stateful->state mutable 
// 3)InheritedWidget


// Design system
// 1)Material Design-Andriod 
// 2)Cupertino design-IOS

// State- data that determines how data looks like or rendered
// builtContext->it tells the position of page in material treee (LOCATION BATAYEGA IN FLUTTER TREE);
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  //optional parameter hai 
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      home: CurrencyConverterMaterialPage(),
    );
    // scaffold instructs flutter to gives us all the things in material app is available to us 

  }



}