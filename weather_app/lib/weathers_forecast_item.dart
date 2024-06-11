import 'package:flutter/material.dart';
class HourlyForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature ;
  const HourlyForecastItem(
    this.time, this.icon,this.temperature, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color:const  Color.fromARGB(131, 64, 65, 64),
      elevation: 7,
      child: Container(
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(23)),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Icon(
              icon,
              size: 32,
            ),
           const  SizedBox(
              height: 6,
            ),
            Text(
              temperature,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
