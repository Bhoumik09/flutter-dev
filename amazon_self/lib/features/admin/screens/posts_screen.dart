import 'package:amazon_self/common/loader.dart';
import 'package:amazon_self/features/account/widgets/single_product.dart';
import 'package:amazon_self/features/admin/screens/add_product_screen.dart';
import 'package:amazon_self/features/admin/services/admin_servicres.dart';
import 'package:amazon_self/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  //this is nullable, as long as we don't get product, a loading indicator will come
  @override
  void initState() {
    // remeber init state cannot be async
    fetchAllProducts();
    super.initState();
  }

  final AdminServices adminServices = AdminServices();
  void navigateToAddProduct() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddProductScreen()),
    );
  }

  //becuase ititstate does not take async optertion there fore we craeted a function outsite and called the instance of require dfunction from that function
  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
    // we need ki jab sab build ho jaye or sara data aa jaye then do changes
  }
  void deleteProduct(Product product,index){
    adminServices.deleteProduct(context: context, onSuccess: (){
      products!.removeAt(index);
      setState(() {});
    }, product: product);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                // learned grid builder here 
                  itemCount: products!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final productData = products![index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProduct(
                            image: productData.images[0],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(onPressed: ()=>deleteProduct(productData,index), icon: const Icon(Icons.delete_outline))
                          ],
                        )
                      ],
                    );
                  }),
            ),
            floatingActionButton: FloatingActionButton(onPressed: navigateToAddProduct,child:const Icon(Icons.add),),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
