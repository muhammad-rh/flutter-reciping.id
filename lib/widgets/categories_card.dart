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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: TextButton(
        child: Text(category),
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 24, 24, 24),
          backgroundColor: const Color.fromRGBO(251, 192, 45, 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
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
