import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/recipe/recipe_view_model.dart';
import 'package:flutter_mini_project/widgets/recipe_item_card.dart';
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

    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Provider.of<RecipeViewModel>(context, listen: false).getRecipeList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Recipe'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<RecipeViewModel>(context, listen: false)
                .getRecipeList();
          },
          child: Column(
            children: [
              Expanded(
                child: Consumer<RecipeViewModel>(
                  builder: (context, value, child) {
                    if (value.dataState == DataState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (value.dataState == DataState.error) {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        print('value.recipeList: $value.recipeList');
                        return RecipeItemCard(
                          title: value.recipeList[index].title ?? 'Untitle',
                          thumb: value.recipeList[index].thumb ?? '',
                          keys: value.recipeList[index].key ?? '',
                          times: value.recipeList[index].times ?? '',
                          portion: value.recipeList[index].portion ?? '',
                          dificulty: value.recipeList[index].dificulty ?? '',
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8.0,
                        );
                      },
                      itemCount: 6,
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
