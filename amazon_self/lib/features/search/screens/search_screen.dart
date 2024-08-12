import 'package:amazon_self/common/loader.dart';
import 'package:amazon_self/constants/global_variables.dart';
import 'package:amazon_self/features/home_screens/screen/widgets/address_box.dart';
import 'package:amazon_self/features/search/services/search_services.dart';
import 'package:amazon_self/features/search/widgets/seached_product.dart';
import 'package:amazon_self/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  const SearchScreen({required this.searchQuery, super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchServices = SearchServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchSeacrhedProducts();
  }

  fetchSeacrhedProducts() async {
    products = await searchServices.fetchSeacrhedProducts(
        context: context, search: widget.searchQuery);
    setState(() {});
  }

  void navigateToSeacrhScreen(String query) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchScreen(searchQuery: query),
      ),
    );
  }

  Widget build(BuildContext context) {
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
      body: products == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return SeachedProduct(product: products![index]);
                    },
                  ),
                )
              ],
            ),
    );
  }
}
