import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/article/article_screen.dart';
import 'package:flutter_mini_project/screens/favourite/favourite_screen.dart';
import 'package:flutter_mini_project/screens/home/home_screen.dart';
import 'package:flutter_mini_project/screens/profile/profile_screen.dart';
import 'package:flutter_mini_project/screens/search/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  final bool isHome;
  final bool isSearch;
  final bool isArticle;
  final bool isFavourite;
  final bool isProfil;
  const BottomNavBar({
    Key? key,
    required this.isHome,
    required this.isSearch,
    required this.isArticle,
    required this.isFavourite,
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
                    color: !isHome
                        ? Colors.white
                        : const Color.fromRGBO(251, 192, 45, 1),
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: !isHome
                          ? Colors.white
                          : const Color.fromRGBO(251, 192, 45, 1),
                    ),
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
                    color: !isSearch
                        ? Colors.white
                        : const Color.fromRGBO(251, 192, 45, 1),
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: !isSearch
                          ? Colors.white
                          : const Color.fromRGBO(251, 192, 45, 1),
                    ),
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
                    color: !isArticle
                        ? Colors.white
                        : const Color.fromRGBO(251, 192, 45, 1),
                  ),
                  Text(
                    'Article',
                    style: TextStyle(
                      color: !isArticle
                          ? Colors.white
                          : const Color.fromRGBO(251, 192, 45, 1),
                    ),
                  ),
                ],
              ),
              onPressed: isArticle
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
                            return const ArticleScreen();
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
                    Icons.favorite,
                    color: !isFavourite
                        ? Colors.white
                        : const Color.fromRGBO(251, 192, 45, 1),
                  ),
                  Text(
                    'Fav',
                    style: TextStyle(
                      color: !isFavourite
                          ? Colors.white
                          : const Color.fromRGBO(251, 192, 45, 1),
                    ),
                  ),
                ],
              ),
              onPressed: isFavourite
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
                            return const FavouriteScreen();
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
                    color: !isProfil
                        ? Colors.white
                        : const Color.fromRGBO(251, 192, 45, 1),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: !isProfil
                          ? Colors.white
                          : const Color.fromRGBO(251, 192, 45, 1),
                    ),
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
