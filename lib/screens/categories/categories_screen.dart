import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/categories/categories_view_model.dart';
import 'package:flutter_mini_project/screens/detail/detail_screen.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/notch_navbar.dart';
import 'package:flutter_mini_project/widgets/search_recipe_card.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  final String keys;
  final String category;
  const CategoriesScreen({
    Key? key,
    required this.keys,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (timeStamp) {
          Provider.of<CategoriesViewModel>(context, listen: false)
              .getCategoryList(widget.keys);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(widget.category),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<CategoriesViewModel>(context, listen: false)
              .getCategoryList(widget.keys);
        },
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: CategoryRecipeListView(keys: widget.keys),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const NotchNavBar(isAdd: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(
        isHome: true,
        isSearch: false,
        isBookmark: false,
        isProfil: false,
      ),
    );
  }
}

class CategoryRecipeListView extends StatelessWidget {
  final String keys;
  const CategoryRecipeListView({
    Key? key,
    required this.keys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFound = false;
    return SizedBox(
      child: Consumer<CategoriesViewModel>(
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

          if (value.recipeList.isNotEmpty) {
            isFound = true;
          } else {
            isFound = false;
          }

          return Scrollbar(
            child: ListView.separated(
              padding: const EdgeInsets.only(
                top: 0,
                left: 8.0,
                right: 8.0,
                bottom: 50.0,
              ),
              itemBuilder: (context, index) {
                if (isFound == true) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          reverseTransitionDuration: const Duration(
                            milliseconds: 500,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return DetailScreen(
                              keys: value.recipeList[index].key ?? '',
                              secondThumb: value.recipeList[index].thumb ?? '',
                            );
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            final tween = Tween(begin: 0.0, end: 1.0);
                            return FadeTransition(
                              opacity: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: SearchRecipeCard(
                      title: value.recipeList[index].title ?? 'Untitle',
                      thumb: value.recipeList[index].thumb ?? '',
                      keys: value.recipeList[index].key ?? '',
                      times: value.recipeList[index].times ?? '',
                      portion: value.recipeList[index].portion ?? '',
                      dificulty: value.recipeList[index].dificulty ?? '',
                    ),
                  );
                }
                return Text(
                  '$keys not found',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 4.0);
              },
              itemCount: isFound ? value.recipeList.length : 1,
            ),
          );
        },
      ),
    );
  }
}
