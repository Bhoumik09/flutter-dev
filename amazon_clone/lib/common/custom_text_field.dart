import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  static const _border =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.black38, ),borderRadius: BorderRadius.all(Radius.circular(8)));
  final bool obscureText;
  final TextEditingController controller;
  final String hintText;
  const CustomTextField(
      {super.key, required this.hintText, required this.controller,this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText, focusedBorder: _border, enabledBorder: _border),
      obscureText: obscureText
      ,validator: (value) {
        if(value==null || value.isEmpty){
          return 'Enter the $hintText';
        }
        return null;
      } ,
    );
  }
}
