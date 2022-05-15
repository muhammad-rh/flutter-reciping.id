import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String thumb;
  const ArticleCard({
    Key? key,
    required this.title,
    required this.thumb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ClipRRect(
                child: Image.network(
                  thumb,
                  height: 200,
                  width: 300,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 4, left: 4, right: 4),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
