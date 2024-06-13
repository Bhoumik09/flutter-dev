import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_flutter/global_varibles.dart';
import 'package:shop_flutter/product_card.dart';
import 'package:shop_flutter/product_detail_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductList();
}

class _ProductList extends State<ProductList> {
  int currentPage = 0;
  final TextEditingController text = TextEditingController();
  final List<String> filters = const ['All', 'Nike', 'Bata', 'Addidas'];
  String? selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    // we have to give value here becuase this runs after stae is run, basically this is the second thing to run before builder
  }

  @override
  Widget build(BuildContext context) {
    const borderProp = OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
        borderSide: BorderSide(
          color: Color.fromRGBO(225, 225, 225, 1),
        ));
    return SafeArea(
      // this widgit avoids the notch of the phone
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Shoes\nCollection",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w700, fontSize: 35),
                ),
              ),
              Expanded(
                // we can use expanded to tel to ask it to take as much space as possible
                child: TextField(
                  controller: text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      enabledBorder: borderProp,
                      focusedBorder: borderProp),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filters[index];
                          });
                        },
                        child: Chip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: selectedFilter == filters[index]
                              ? Colors.yellow
                              : const Color.fromRGBO(245, 247, 249, 1),
                          label: Text(
                            filters[index],
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (selectedFilter == 'All' ||
                      selectedFilter == products[index]['company']) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetails(product: products[index]);
                              },
                            ),
                          );
                          // pushReplacemnet replaces the entire screen with another scren, just as justifing something in array using slicing (Used in login and register only )
                          // push and pop does same work as expected
                        },
                        child: ProductCard(
                            id: products[index]['id'] as String,
                            price: products[index]['price'] as double,
                            image: products[index]['imageUrl'] as String,
                            title: products[index]['title'] as String));
                  }
                  else{
                    return const SizedBox(height: 0,);
                  }
                }),
          )
        ],
      ),
    );
  }
}
