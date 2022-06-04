import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/favourite/favourite_view_model.dart';
import 'package:flutter_mini_project/screens/recipe_detail/recipe_detail_screen.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/search_list_card.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FavouriteViewModel>(context, listen: false)
          .syncDataWithProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<FavouriteViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite'),
        backgroundColor: const Color.fromARGB(255, 215, 14, 14),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              manager.deleteFavourite(index);
            },
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return RecipeDetailScreen(
                      keys: manager.recipeList[index].id!,
                      secondThumb: manager.recipeList[index].thumb!,
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
            child: SearchListCard(
              title: manager.recipeList[index].title ?? 'Untitle',
              thumb: manager.recipeList[index].thumb ?? '',
              keys: manager.recipeList[index].id ?? '',
              times: manager.recipeList[index].times ?? '',
              portion: manager.recipeList[index].servings ?? '',
              dificulty: manager.recipeList[index].dificulty ?? '',
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8.0);
        },
        itemCount: manager.recipeList.length,
      ),
      bottomNavigationBar: const BottomNavBar(
        isHome: false,
        isSearch: false,
        isArticle: false,
        isFavourite: true,
        isProfil: false,
      ),
    );
  }
}
