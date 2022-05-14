import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/detail/detail_screen.dart';
import 'package:flutter_mini_project/screens/search/search_view_model.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/search_field.dart';
import 'package:flutter_mini_project/widgets/search_list_card.dart';
import 'package:provider/provider.dart';

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
          Provider.of<SearchViewModel>(context, listen: false)
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
          Provider.of<SearchViewModel>(context, listen: false)
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
                      bottom: false,
                      child: SearchField(),
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
        isBookmark: false,
        isProfil: false,
      ),
    );
  }

  SizedBox searchScreenListView({required String keys}) {
    return SizedBox(
      child: Consumer<SearchViewModel>(
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
                            return DetailScreen(
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
                      title: value.recipeList[index].title ?? 'Untitle',
                      thumb: value.recipeList[index].thumb ?? '',
                      keys: value.recipeList[index].key ?? '',
                      times: value.recipeList[index].times ?? '',
                      portion: value.recipeList[index].serving ?? '',
                      dificulty: value.recipeList[index].difficulty ?? '',
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
