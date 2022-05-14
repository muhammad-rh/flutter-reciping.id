import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/home/home_screen.dart';
import 'package:flutter_mini_project/screens/profile/profile_screen.dart';
import 'package:flutter_mini_project/screens/search/search_screen.dart';

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
      color: const Color.fromARGB(255, 215, 14, 14),
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 60,
            height: 56,
            child: IconButton(
              icon: Column(
                children: [
                  Icon(
                    Icons.home_filled,
                    color: isHome ? Colors.white : Colors.grey,
                  ),
                  Text(
                    'Home',
                    style:
                        TextStyle(color: isHome ? Colors.white : Colors.grey),
                  ),
                ],
              ),
              onPressed: isHome
                  ? () {}
                  : () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          reverseTransitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const HomeScreen();
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
          ),
          SizedBox(
            width: 60,
            height: 56,
            child: IconButton(
              icon: Column(
                children: [
                  Icon(
                    Icons.search,
                    color: isSearch ? Colors.white : Colors.grey,
                  ),
                  Text(
                    'Search',
                    style:
                        TextStyle(color: isSearch ? Colors.white : Colors.grey),
                  ),
                ],
              ),
              onPressed: isSearch
                  ? () {}
                  : () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          reverseTransitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const SearchScreen(search: '');
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
          ),
          SizedBox(
            height: 56,
            width: 60,
            child: IconButton(
              icon: Column(
                children: [
                  Icon(
                    Icons.library_books,
                    color: isBookmark ? Colors.white : Colors.grey,
                  ),
                  Text(
                    'Article',
                    style: TextStyle(
                        color: isBookmark ? Colors.white : Colors.grey),
                  ),
                ],
              ),
              onPressed: isBookmark
                  ? () {}
                  : () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          reverseTransitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const ProfileScreen();
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
          ),
          SizedBox(
            height: 56,
            width: 60,
            child: IconButton(
              icon: Column(
                children: [
                  Icon(
                    Icons.person,
                    color: isProfil ? Colors.white : Colors.grey,
                  ),
                  Text(
                    'Profil',
                    style:
                        TextStyle(color: isProfil ? Colors.white : Colors.grey),
                  ),
                ],
              ),
              onPressed: isProfil
                  ? () {}
                  : () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          reverseTransitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const ProfileScreen();
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
          ),
        ],
      ),
    );
  }
}
