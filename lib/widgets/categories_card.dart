import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  final String category;
  final String keys;
  const CategoriesCard({
    Key? key,
    required this.category,
    required this.keys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: TextButton(
        child: Text(category),
        style: TextButton.styleFrom(
          primary: Colors.teal,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
