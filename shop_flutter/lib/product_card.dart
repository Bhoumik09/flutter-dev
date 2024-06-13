import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final String id;
  const ProductCard(
      {super.key,
      required this.title,
      required this.price,
      required this.image,
      required this.id});
  
  @override
  Widget build(BuildContext context) {
     
    return Container(
      margin:const  EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color :(int.parse(id)%2==0?const  Color.fromRGBO(216, 240, 253, 1):Color.fromARGB(255, 255, 255, 255)) 
),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(
            height: 5,
          ),
          Text("\$$price", style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(
            height: 5,
          ),
          Center(child: Image(height: 175, image: AssetImage(image)))
          // Image.asset(image,height:174), naother way to add image
        ],
      ),
    );
  }
}
