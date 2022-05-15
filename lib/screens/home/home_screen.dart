import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/home/home_view_model.dart';
import 'package:flutter_mini_project/screens/recipe_detail/recipe_detail_screen.dart';
import 'package:flutter_mini_project/services/auth_service.dart';
import 'package:flutter_mini_project/widgets/article_card.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/categories_card.dart';
import 'package:flutter_mini_project/widgets/recipe_list_card.dart';
import 'package:flutter_mini_project/widgets/search_field.dart';
import 'package:flutter_mini_project/widgets/shimmer_categories_card.dart';
import 'package:flutter_mini_project/widgets/shimmer_recipe_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
        await Provider.of<AuthServices>(context, listen: false).retrieveUser();
        Provider.of<HomeViewModel>(context, listen: false).getRecipeList();
        Provider.of<HomeViewModel>(context, listen: false).getCategoryList();
        Provider.of<HomeViewModel>(context, listen: false)
            .getArticleList('tips-masak');
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<AuthServices>(
                  builder: (context, value, child) {
                    if (value.loggedInUser.uid == null) {
                      return Center(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade300,
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 4),
                            title: Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              width: 50,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.amber,
                              ),
                            ),
                            subtitle: Container(
                              width: 100,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.amber,
                              ),
                            ),
                            trailing: CircleAvatar(
                              radius: 24,
                              child: Container(
                                width: 20,
                                height: 20,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      title: Text(
                        'Hello, ${value.loggedInUser.firstName}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        'What do you want cook today?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: SizedBox(
                        height: 46,
                        child: value.loggedInUser.imgUrl != null
                            ? ClipOval(
                                child: Image.network(
                                  value.loggedInUser.imgUrl!,
                                  fit: BoxFit.cover,
                                  width: 48,
                                  height: 48,
                                ),
                              )
                            : CircleAvatar(
                                child: Text(
                                  '${value.loggedInUser.firstName?[0].toUpperCase()}${value.loggedInUser.lastName?[0].toUpperCase()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                radius: 24,
                                backgroundColor:
                                    const Color.fromRGBO(251, 192, 45, 1),
                              ),
                      ),
                    );
                  },
                ),
                SearchField(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Image.asset('assets/categories.png', height: 20, width: 20),
                    const SizedBox(width: 5),
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                categories(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Image.asset('assets/recipe.png', height: 20, width: 20),
                    const SizedBox(width: 5),
                    const Text(
                      'Today\'s Recipes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                todaysRecipes(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Image.asset('assets/tips.png', height: 20, width: 20),
                    const SizedBox(width: 5),
                    const Text(
                      'Cooking Tips',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                cookingTips(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        isHome: true,
        isSearch: false,
        isBookmark: false,
        isProfil: false,
      ),
    );
  }

  SizedBox cookingTips() {
    return SizedBox(
      height: 300,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          if (value.dataState == DataState.loading) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade300,
                child: ListView.separated(
                  padding: const EdgeInsets.all(4.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const ShimmerRecipeCard();
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12.0);
                  },
                  itemCount: 6,
                ),
              ),
            );
          }

          if (value.dataState == DataState.error) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(left: 0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: ArticleCard(
                  title: value.articleList[index].title!,
                  thumb: value.articleList[index].thumb!,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 4.0);
            },
            itemCount: value.articleList.length,
          );
        },
      ),
    );
  }

  SizedBox todaysRecipes() {
    return SizedBox(
      height: 330,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          if (value.dataState == DataState.loading) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade300,
                child: ListView.separated(
                  padding: const EdgeInsets.all(4.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const ShimmerRecipeCard();
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12.0);
                  },
                  itemCount: 6,
                ),
              ),
            );
          }

          if (value.dataState == DataState.error) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(left: 0),
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
                        return RecipeDetailScreen(
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
                child: RecipeListCard(
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

  SizedBox categories() {
    return SizedBox(
      height: 50,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          if (value.dataState == DataState.loading) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade300,
                  child: const ShimmerCategoriesCard(),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 4.0);
              },
              itemCount: 5,
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
