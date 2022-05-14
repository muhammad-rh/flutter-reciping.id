import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/search/search_screen.dart';

class SearchField extends StatefulWidget {
  String? searchkey;
  SearchField({
    Key? key,
    this.searchkey,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  var _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.searchkey != null) {
      _searchController.text = widget.searchkey!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 215, 14, 14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onEditingComplete: () {
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
        style: const TextStyle(color: Color.fromARGB(255, 248, 249, 253)),
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search any recipes...',
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 248, 249, 253),
            height: 3.2,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromARGB(255, 248, 249, 253),
          ),
          suffixIcon: Icon(
            Icons.display_settings_rounded,
            color: Color.fromARGB(255, 248, 249, 253),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
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
