import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/recipe/recipe_list_screen.dart';
import 'package:flutter_mini_project/screens/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<RecipeViewModel>(context, listen: false).initialState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeViewModel = Provider.of<RecipeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Recipe'),
      ),
      body: buildRecipeScreen(),
    );
  }

  Widget buildRecipeScreen() {
    return Consumer<RecipeViewModel>(
      builder: (context, value, child) {
        if (value.recipes.isNotEmpty) {
          return const RecipeListScreen();
        } else {
          return const Center(
            child: Text('Recipe masih kosong'),
          );
        }
      },
    );
  }
}
