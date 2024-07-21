import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AuthService{
  void signUpUser({
    required BuildContext context,
    required String email, 
    required String password,
    required String name
  })async{
    try{
      User user=User(id: '', name: name, password: password, address: '', type: '', token: '',email: email);
      http.Response response = await http.post(
  Uri.parse("$uri/api/signup"),
  body: user.toJson(),
  headers: <String, String>{
    'Content-Type': "application/json;charset=UTF-8"
  }
);
      httpErrorHandleFunction(response: response, context: context, onSuccess: (){
        showSnackBar(context, 'Account has been created ');
      });
    }catch(e){
      showSnackBar(context, e.toString());

    }
  }
}