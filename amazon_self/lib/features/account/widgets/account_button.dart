import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({required this.text, required this.onTap, super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        height: 40,
        decoration: BoxDecoration(
          
            border: Border.all(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(50),
            color:const  Color.fromARGB(255, 255, 255, 255)),
        child: OutlinedButton(
          
          style: ElevatedButton.styleFrom(
            backgroundColor:const Color.fromARGB(255, 133, 155, 20).withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
