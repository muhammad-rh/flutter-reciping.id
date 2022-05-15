import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/article_detail/article_detail_screen.dart';

class ArticleListCard extends StatelessWidget {
  final String title;
  final String thumb;
  final String keys;
  final String tags;
  const ArticleListCard({
    Key? key,
    required this.title,
    required this.thumb,
    required this.keys,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            child: Image.network(
              thumb,
              height: 170,
              width: 170,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 35,
                width: 130,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        reverseTransitionDuration:
                            const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return ArticleDetailScreen(
                            tags: tags,
                            keys: keys,
                            secondThumb: thumb,
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final tween2 = Tween(begin: 0.0, end: 1.0);
                          return FadeTransition(
                            opacity: animation.drive(tween2),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    primary: Colors.white,
                    backgroundColor: const Color.fromRGBO(251, 192, 45, 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "More",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 24, 24, 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
