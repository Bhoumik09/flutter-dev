import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  
    final List<Map<String,dynamic>> cart=[];
    void addProduct(Map<String,dynamic>product){
      cart.add(product);
      print(cart);
      notifyListeners();
    }
    void removeProduct(Map<String,dynamic>product){
      cart.remove(product);
      notifyListeners();
      // it just notifies all the things listenung to cart provider
    }
}