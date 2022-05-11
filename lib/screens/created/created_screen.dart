import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/add/add_screen.dart';
import 'package:flutter_mini_project/utils/db_manager.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/create_recipe_card.dart';
import 'package:flutter_mini_project/widgets/notch_navbar.dart';
import 'package:provider/provider.dart';

class CreatedScreen extends StatelessWidget {
  const CreatedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<DbManager>(context, listen: false);
        },
        child: Consumer<DbManager>(
          builder: (context, value, child) {
            return ListView.separated(
              itemBuilder: (context, index) {
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
                    id: value.recipeList[index].id!,
                    title: value.recipeList[index].title!,
                    thumb: value.recipeList[index].thumb!,
                    servings: value.recipeList[index].servings!,
                    times: value.recipeList[index].times!,
                    dificulty: value.recipeList[index].dificulty!,
                    datePublished: value.recipeList[index].datePublished!,
                    desc: value.recipeList[index].desc!,
                    ingredient: value.recipeList[index].ingredient!,
                    step: value.recipeList[index].step!,
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
      ),
      floatingActionButton: const NotchNavBar(isAdd: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(
        isHome: false,
        isSearch: false,
        isBookmark: true,
        isProfil: false,
      ),
    );
  }
}
