import 'package:amazon_self/constants/global_variables.dart';
import 'package:amazon_self/features/account/screen/account_screen.dart';
import 'package:amazon_self/features/home_screens/screen/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottonNavigationBar extends StatefulWidget {
  const BottonNavigationBar({super.key});

  @override
  State<BottonNavigationBar> createState() => _BottonNavigationBarState();
}

class _BottonNavigationBarState extends State<BottonNavigationBar> {
  int _page = 0;
  double bottomNavigationBarWidth = 42;
  double bottomNavigationBarItemWidth = 5;
  void updatePage(int page){
    setState(() {
      _page=  page;
    });
  }
  List<Widget>pages=[
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text('CartPage'),),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap:updatePage ,
        // the bottom vaigation bar implicity sends updatePage(currentIndex)
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavigationBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomNavigationBarItemWidth,
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavigationBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomNavigationBarItemWidth,
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavigationBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomNavigationBarItemWidth,
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Badge(
                label: Text('1'),
                child: Icon(Icons.shopping_cart_outlined),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
