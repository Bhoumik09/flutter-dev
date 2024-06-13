import 'package:flutter/material.dart';
import 'package:shop_flutter/cart_page.dart';
import 'package:shop_flutter/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages=const [
    ProductList(), CartPage()
  ];
  int currentPage=0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 35,
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage=value;
          });
        },
        selectedItemColor: Colors.yellow,
        items: const [
          BottomNavigationBarItem(
            
            label: '',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.shopping_cart))
        ],
      ),
      body:  IndexedStack(index:currentPage, children: pages,) ,
      // indexed staxk is used to maintain the positions that we left on the page m there fore when we retrurn to the page, we get the page on the same position 
    );
  }
}
