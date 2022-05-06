import 'package:flutter/material.dart';

class RecipeItemCard extends StatelessWidget {
  final String title;
  final String thumb;
  final String keys;
  final String times;
  final String portion;
  final String dificulty;
  const RecipeItemCard({
    Key? key,
    required this.title,
    required this.thumb,
    required this.keys,
    required this.times,
    required this.portion,
    required this.dificulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(
                thumb,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: 100,
              child: Column(
                children: [
                  Text(title),
                  Text(keys),
                  Text(times),
                  Text(portion),
                  Text(dificulty),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
