import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/detail/detail_screen.dart';
import 'package:flutter_mini_project/screens/home/home_view_model.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/categories_card.dart';
import 'package:flutter_mini_project/widgets/new_recipe_card.dart';
import 'package:flutter_mini_project/widgets/notch_navbar.dart';
import 'package:flutter_mini_project/widgets/search_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Provider.of<HomeViewModel>(context, listen: false).getRecipeList();
        Provider.of<HomeViewModel>(context, listen: false).getCategoryList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<HomeViewModel>(context, listen: false).getRecipeList();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 4),
                  title: Text(
                    'Hello, Your Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'What do you want cook today?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: CircleAvatar(
                    child: Text('A'),
                    radius: 24,
                  ),
                ),
                SearchField(),
                const SizedBox(height: 16),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                const CategoriesListView(),
                const SizedBox(height: 16),
                const Text(
                  'New Recipes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                const NewRecipesListView(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: const NotchNavBar(
        isAdd: false,
      ),
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

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Consumer<HomeViewModel>(
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
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoriesCard(
                category: value.categoryList[index].category ?? 'UnCategories',
                keys: value.categoryList[index].key ?? '',
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 4.0);
            },
            itemCount: value.categoryList.length,
          );
        },
      ),
    );
  }
}

class NewRecipesListView extends StatelessWidget {
  const NewRecipesListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Consumer<HomeViewModel>(
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
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
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
                      pageBuilder: (context, animation, secondaryAnimation) {
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
                child: NewRecipeCard(
                  title: value.recipeList[index].title ?? 'Untitle',
                  thumb: value.recipeList[index].thumb ?? '',
                  keys: value.recipeList[index].key ?? '',
                  times: value.recipeList[index].times ?? '',
                  portion: value.recipeList[index].portion ?? '',
                  dificulty: value.recipeList[index].dificulty ?? '',
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 4.0);
            },
            itemCount: value.recipeList.length,
          );
        },
      ),
    );
  }
}
