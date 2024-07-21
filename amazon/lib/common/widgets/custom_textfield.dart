import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText; 
  final bool obscureText;
  const CustomTextfield({super.key, required this.controller, required this.hintText, this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(borderSide:BorderSide(color: Colors.black38), 
        ),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black38))
      ),
      validator: (value) {
        if(value==null || value.isEmpty){
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}