import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // It searched the type of provider giving string, up the widget tree
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final cartItem = cart[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                  // here avatar back ground needs image provider as asset image or Network images(like the images from the web )
                  backgroundColor: Colors.yellow,
                  radius: 30,
                ),
                title: Text(
                  cartItem['title'] as String,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  "Size ${cartItem['size']}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Delete Product ",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: const Text(
                                'Are u sure u want ot remove the product from your cart ? '),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // bascally the dialog box gets stacked on the cart, therefore we have to remove it
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    context
                                        .read<CartProvider>()
                                        .removeProduct(cartItem);
                                    // another way to write bellow line
                                    // Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              );
            }));
  }
}
