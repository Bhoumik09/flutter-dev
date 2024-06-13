import 'package:flutter/cupertino.dart';

class CurrCupertinoConverter extends StatefulWidget {
  const CurrCupertinoConverter({super.key});

  @override
  State<CurrCupertinoConverter> createState() => _CurrCupertinoConverterState();
}

class _CurrCupertinoConverterState extends State<CurrCupertinoConverter> {
   double result = 0;
  final TextEditingController text = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    text.dispose();
    super.dispose();
    // to insure that data leaks nah ho, page change, or widget no longer use 
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("built");

    

    return CupertinoPageScaffold(
      navigationBar:const  CupertinoNavigationBar(
        // elevation: 0,
        backgroundColor: CupertinoColors.systemGrey3,
        middle: Text("Currency Converter"),
      ),
      backgroundColor: const Color.fromARGB(255, 132, 124, 124),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // int->int.parsse(string)
            Text(
              "INR ${result != 0 ? result.toStringAsFixed(2) : 0}",
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w900,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              child: CupertinoTextField(
                controller: text,
                style: const TextStyle(color: CupertinoColors.black),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                  color: CupertinoColors.white,
                  
                ),
                placeholder: "Please enter the amount in USD",
                prefix:const Icon(CupertinoIcons.money_dollar), 
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CupertinoButton(
                onPressed: () {
                  setState(() {
                    result = double.parse(text.text) * 81;
                  });
                },
                color: CupertinoColors.black,
                
                
                child: const Text("Convert"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}