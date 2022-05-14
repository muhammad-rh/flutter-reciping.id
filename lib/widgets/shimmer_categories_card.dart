import 'package:flutter/material.dart';

class ShimmerCategoriesCard extends StatelessWidget {
  const ShimmerCategoriesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
      ),
    );
  }
}
