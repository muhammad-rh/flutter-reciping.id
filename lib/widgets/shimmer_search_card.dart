import 'package:flutter/material.dart';

class ShimmerSearchCard extends StatelessWidget {
  const ShimmerSearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
      ),
    );
  }
}
