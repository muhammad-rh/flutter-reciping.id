import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final bool isHome;
  final bool isSearch;
  final bool isBookmark;
  final bool isProfil;
  const BottomNavBar({
    Key? key,
    required this.isHome,
    required this.isSearch,
    required this.isBookmark,
    required this.isProfil,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.redAccent,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home_filled,
              color: isHome ? Colors.white : Colors.grey,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: isSearch ? Colors.white : Colors.grey,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 40),
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: isBookmark ? Colors.white : Colors.grey,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: isProfil ? Colors.white : Colors.grey,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
