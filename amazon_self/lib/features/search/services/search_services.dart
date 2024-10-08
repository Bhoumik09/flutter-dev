import 'dart:convert';

import 'package:amazon_self/constants/error_handling.dart';
import 'package:amazon_self/constants/global_variables.dart';
import 'package:amazon_self/constants/utils.dart';
import 'package:amazon_self/models/product.dart';
import 'package:amazon_self/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices{
  Future<List<Product>> fetchSeacrhedProducts(
      {required BuildContext context, required String search}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$search'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandleFunction(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}