import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/recipe/recipe_view_model.dart';
import 'package:flutter_mini_project/widgets/recipe_item_card.dart';
import 'package:provider/provider.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipeViewModel = Provider.of<RecipeViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final item = recipeViewModel.recipes[index];
          return RecipeItemCard(
            recipeItem: recipeViewModel.recipes[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: recipeViewModel.recipes.length,
      ),
    );
  }
}
