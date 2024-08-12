import 'package:amazon_self/constants/global_variables.dart';
import 'package:amazon_self/features/home_screens/screen/widgets/address_box.dart';
import 'package:amazon_self/features/home_screens/screen/widgets/carousel_image.dart';
import 'package:amazon_self/features/home_screens/screen/widgets/deal_of_day.dart';
import 'package:amazon_self/features/home_screens/screen/widgets/top_categories.dart';
import 'package:amazon_self/features/search/screens/search_screen.dart';
import 'package:amazon_self/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSeacrhScreen(String query) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchScreen(searchQuery: query),
      ),
    );
  }
    @override

  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSeacrhScreen,
                        //here when the filed is submitted, its value will be passed in the function
                        decoration: InputDecoration(
                            hintText: 'Search Amazon.in',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                    size: 25,
                  ),
                )
              ],
            ),
            flexibleSpace: Container(
              //onnly to pass the gradient
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          ),
        ),
        // warp the column with single child scroll view so that overflow error could be saved
        body: const SingleChildScrollView(
          child: Column(
            children: [
              AddressBox(),
              SizedBox(
                height: 10,
              ),
              TopCategories(),
              SizedBox(
                height: 10,
              ),
              CarouselImage(),
              DealOfDay(),
            ],
          ),
        ));
  }
}
