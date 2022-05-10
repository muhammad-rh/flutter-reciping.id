import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/search/search_screen.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
  }) : super(key: key);

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 23, 47, 69),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Search any recipes...',
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              if (_searchController.text.isNotEmpty) {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(
                      milliseconds: 500,
                    ),
                    reverseTransitionDuration: const Duration(
                      milliseconds: 500,
                    ),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return SearchScreen(search: _searchController.text);
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
              }
            },
            child: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 248, 249, 253),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.transparent,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
