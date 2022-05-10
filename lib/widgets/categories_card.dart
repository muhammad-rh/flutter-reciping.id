import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/categories/categories_screen.dart';

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
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(
                milliseconds: 500,
              ),
              reverseTransitionDuration: const Duration(
                milliseconds: 500,
              ),
              pageBuilder: (context, animation, secondaryAnimation) {
                return CategoriesScreen(
                  keys: keys,
                  category: category,
                );
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final tween = Tween(begin: 0.0, end: 1.0);
                return FadeTransition(
                  opacity: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
