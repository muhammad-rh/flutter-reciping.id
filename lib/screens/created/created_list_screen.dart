import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/add/add_screen.dart';
import 'package:flutter_mini_project/utils/db_manager.dart';
import 'package:flutter_mini_project/widgets/create_recipe_card.dart';
import 'package:provider/provider.dart';

class CreatedListScreen extends StatelessWidget {
  final DbManager manager;
  const CreatedListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<DbManager>(context, listen: false);
      },
      child: Consumer<DbManager>(
        builder: (context, value, child) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final item = value.recipeList[index];
              return GestureDetector(
                onTap: () async {
                  final selectedRecipe =
                      await value.getRecipeByid(value.recipeList[index].id!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddScreen(
                        recipe: selectedRecipe,
                      ),
                    ),
                  );
                },
                child: CreateRecipeCard(
                  recipe: item,
                  onPressed: () {
                    value.deleteRecipe(value.recipeList[index].id!);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${value.recipeList[index].title} Deleted'),
                      ),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 4);
            },
            itemCount: value.recipeList.length,
          );
        },
      ),
    );
  }
}
