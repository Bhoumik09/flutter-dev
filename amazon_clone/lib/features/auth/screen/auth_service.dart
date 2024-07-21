import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {'email': email, 'password': password},
        ),
      );
      print (response.body);
      httpErrorHandleFunction(
          response: response,
          context: context,
          onSuccess: () {
            
          });
    } catch (e) {
            showSnackBar(context, e.toString());
    }
  }

  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse("$uri/api/signup"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:
              jsonEncode({'name': name, 'email': email, 'password': password}));
      httpErrorHandleFunction(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account has been created ');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
