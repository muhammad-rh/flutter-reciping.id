import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/recipe_model.dart';

class RecipeItemCard extends StatelessWidget {
  final RecipeModel recipeItem;
  const RecipeItemCard({
    Key? key,
    required this.recipeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text(recipeItem.title!),
            Image.network(recipeItem.thumb!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(recipeItem.times!),
                Text(recipeItem.portion!),
                Text(recipeItem.dificulty!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
