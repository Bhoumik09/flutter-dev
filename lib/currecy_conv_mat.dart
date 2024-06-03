import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  CurrencyConverterMaterialPage({super.key}) {
    debugPrint("construtor");
  }

  @override
  State createState() {
    debugPrint("create state");
    return _CurrencyConverterMaterialPageState();
  }
}

class _CurrencyConverterMaterialPageState extends State {
  double result = 0;
  final TextEditingController text = TextEditingController();
  //we have to built function as light as possibble, async task hamesha bahar hi aayenga
  @override
  void initState() {
    super.initState();
    debugPrint("rebuilt");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("built");
    
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 27, 14, 13),
        width: 2.0,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );

    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: const Color.fromARGB(255, 132, 124, 124),
        title: const Text(
          "Currency Converter",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 132, 124, 124),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // int->int.parsse(string)
            Text(
              result.toString(),
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w900,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: text,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Pls enter the amount in USD",
                  hintStyle: TextStyle(color: Colors.white60),
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    
                    result = double.parse(text.text)*81;
                  });
                },
                style: ElevatedButton.styleFrom(
                  // this should be used every time
                  backgroundColor:
                      Colors.white, // Set the background color to white
                  foregroundColor: Colors.black, // Set the text color to black
                  elevation: 20, // Set the elevation value (adjust as needed)
                  minimumSize:
                      const Size(double.infinity, 50), // Set the minimum size
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Set the border radius
                  ),
                ),
                child: const Text("Convert"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
