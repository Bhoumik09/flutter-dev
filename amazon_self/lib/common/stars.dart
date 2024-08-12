import 'package:amazon_self/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({required this.rating,super.key});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(direction: Axis.horizontal,itemCount: 5,rating: rating,itemSize: 15,itemBuilder: (context, _) =>
      const Icon(Icons.star,color: GlobalVariables.secondaryColor)
    );
    //ietm count will tell how many stars should be seen and rating tells the rating given by the user 
  }
}