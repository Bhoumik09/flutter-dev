import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/cart_provider.dart';
import 'package:shop_flutter/global_varibles.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize=0;
  void onTap() {
    if(selectedSize!=0){
    Provider.of<CartProvider>(context, listen: false).addProduct({
      'id': widget.product['id'],
      'title': widget.product['title'],
      'price': widget.product['price'],
      'imageUrl': widget.product['imageUrl'],
      'company': widget.product['Company'],
      'size': selectedSize,
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product Added SuccessFully")));

    
    
  }else{
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a size")));
  }
  } 

  // HERE , we were able to access the context outside the build context becuase the state has a method of build context, which gives us the context
  // in stateless widget , we can't do it
  @override
  void initState() {
    super.initState();
    // selectedSize = (widget.product['sizes'] as List)[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 35),
          ),
          const Spacer(
            flex: 3,
          ),
          // this flex is the count if flex =2 , then it will take the height and wwidth of a single flex
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl'] as String),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "\$${widget.product['price']}",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w700, fontSize: 35),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List).length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize =
                                    (widget.product['sizes'] as List)[index];
                              });
                            },
                            child: Chip(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                backgroundColor: selectedSize ==
                                        (widget.product['sizes'] as List)[index]
                                    ? Colors.yellow
                                    : const Color.fromRGBO(245, 247, 249, 1),
                                label: Text(
                                    "${(widget.product['sizes'] as List)[index]}")),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: onTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                          Text(
                            "\tAdd to cart",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
