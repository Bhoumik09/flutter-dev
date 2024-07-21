import 'dart:convert';

import 'package:amazon_self/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
void httpErrorHandleFunction({
  required BuildContext context,
  required VoidCallback onSuccess,
  required http.Response response,
}){
  switch(response.statusCode){
    case 200:
      onSuccess();
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
    default:
      showSnackBar(context, jsonDecode(response.body)['error']);
  }
}