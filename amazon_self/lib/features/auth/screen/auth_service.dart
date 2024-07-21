import 'dart:convert';


import 'package:amazon_self/constants/error_handling.dart';
import 'package:amazon_self/constants/global_variables.dart';
import 'package:amazon_self/constants/utils.dart';
import 'package:amazon_self/features/home_screens/screen/home_screen.dart';
import 'package:amazon_self/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      httpErrorHandleFunction(
          response: response,
          context: context,
          onSuccess: ()async {
            //we get a string as response.body
            SharedPreferences prefs= await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context,listen: false).setUser(response.body);
            await prefs.setString('x-auth-token', jsonDecode(response.body)['token']);
            Navigator.of(context).push( MaterialPageRoute(builder: (context) => const HomeScreen()));
          });
    } catch (e) {
            showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
    
  }) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? token=prefs.getString('x-auth-token');
    if(token==null){
      prefs.setString('x-auth-token', '');
          // user has come first time 
    }
    var tokenRes=await http.post(Uri.parse('$uri/tokenIsValid'),headers:<String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token':token!
    } );
    var response= jsonDecode(tokenRes.body);
    if(response){
      http.Response userRes= await http.get(Uri.parse('$uri/'),headers:<String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token':token
    } );
    
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    userProvider.setUser(userRes.body);
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
