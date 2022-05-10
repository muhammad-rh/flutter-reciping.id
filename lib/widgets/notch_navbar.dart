import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/add/add_screen.dart';

class NotchNavBar extends StatelessWidget {
  final bool isAdd;
  const NotchNavBar({
    Key? key,
    required this.isAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(
              milliseconds: 500,
            ),
            reverseTransitionDuration: const Duration(
              milliseconds: 500,
            ),
            pageBuilder: (context, animation, secondaryAnimation) {
              return const AddScreen();
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
      child: Icon(
        Icons.add,
        color: isAdd ? Colors.white : Colors.grey,
      ),
    );
  }
}
