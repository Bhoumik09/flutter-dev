import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});
  @override
  State createState() {
    return _CurrencyConverter();
  }
}

class _CurrencyConverter extends State {
  final TextEditingController text=TextEditingController();
  double result=0.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const border=OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 3),borderRadius: BorderRadius.all(Radius.circular(23)),
                  gapPadding:20.0);
    return  Scaffold(
      appBar: AppBar(title: const Text("Currency Converter",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Colors.red,centerTitle: true,),
      body: Center(
        
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              
             Text(
              result.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child:  TextField(
                controller: text,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  
                  hintText: "Enter the currency in USD",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.monetization_on_outlined, color: Colors.white,),
                  enabledBorder: border,
                  focusedBorder: border,
                  filled: true,
                  fillColor: Color.fromRGBO(211, 24, 24, 0.736),

                  
                ),
              ),
            ),
             ElevatedButton(onPressed:(){
              setState(() {
                result=double.parse(text.text)*98;
              });
             },style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white,elevation: 30), child:  const Text("Press me"),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   )
          ],
        ),
      ),
      backgroundColor: Colors.red,
    );
  }
}
