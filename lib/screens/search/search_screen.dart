import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/home/home_view_model.dart';
import 'package:flutter_mini_project/screens/recipe_detail/recipe_detail_screen.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/search_field.dart';
import 'package:flutter_mini_project/widgets/search_list_card.dart';
import 'package:flutter_mini_project/widgets/shimmer_search_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  final String search;
  const SearchScreen({
    Key? key,
    required this.search,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (timeStamp) {
          Provider.of<HomeViewModel>(context, listen: false)
              .searchRecipeList(widget.search);
        },
      );
    }
  }

  bool isFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<HomeViewModel>(context, listen: false)
              .searchRecipeList(widget.search);
        },
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SafeArea(
                      child: SearchField(searchkey: widget.search),
                    ),
                  ),
                  Expanded(
                    child: searchScreenListView(keys: widget.search),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        isHome: false,
        isSearch: true,
        isArticle: false,
        isProfil: false,
      ),
    );
  }

  SizedBox searchScreenListView({required String keys}) {
    return SizedBox(
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          if (value.dataState == DataState.loading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade300,
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return const ShimmerSearchCard();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12.0);
                },
                itemCount: 10,
              ),
            );
          }

          if (value.dataState == DataState.error) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (value.searchList.isNotEmpty) {
            isFound = true;
          } else {
            isFound = false;
          }

          return Scrollbar(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                if (isFound == true) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return RecipeDetailScreen(
                              keys: value.recipeList[index].key!,
                              secondThumb: value.recipeList[index].thumb!,
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
                      title: value.searchList[index].title ?? 'Untitle',
                      thumb: value.searchList[index].thumb ?? '',
                      keys: value.searchList[index].key ?? '',
                      times: value.searchList[index].times ?? '',
                      portion: value.searchList[index].serving ?? '',
                      dificulty: value.searchList[index].difficulty ?? '',
                    ),
                  );
                }
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Image.asset(
                        'assets/not_found.png',
                        height: 400,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '$keys not found',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4.0);
              },
              itemCount: isFound ? value.searchList.length : 1,
            ),
          );
        },
      ),
    );
  }
}
