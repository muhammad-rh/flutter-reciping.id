import 'package:flutter/material.dart';

class ShimmerRecipeCard extends StatelessWidget {
  const ShimmerRecipeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
      ),
    );
  }
}
