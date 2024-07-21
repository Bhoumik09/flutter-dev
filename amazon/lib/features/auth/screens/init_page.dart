import 'package:amazon/features/auth/screens/auth_screens.dart';
import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Center(
              child: Text("flutter"),
            ),
            ElevatedButton(child:const Text("click me ") ,onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AuthScreen()));
            },)
          ],
        ),
      ) ;
  }
}