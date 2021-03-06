import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/home/home_view_model.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/catagories_list_card.dart';
import 'package:flutter_mini_project/widgets/shimmer_categories_list.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<HomeViewModel>(context, listen: false)
            .getCategoriesList(widget.keys);
      },
    );
  }

  bool isFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: const Color.fromARGB(255, 215, 14, 14),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<HomeViewModel>(context, listen: false)
              .getCategoriesList(widget.keys);
        },
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: categoryRecipeList(keys: widget.keys),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        isHome: false,
        isSearch: false,
        isArticle: false,
        isFavourite: false,
        isProfil: false,
      ),
    );
  }

  SizedBox categoryRecipeList({required String keys}) {
    return SizedBox(
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          if (value.dataState == DataState.loading) {
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade300,
                  child: const ShimmerCategoriesList(),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4.0);
              },
              itemCount: 10,
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
                return CategoriesListCard(
                  title: value.categoriesList[index].title ?? 'Untitle',
                  thumb: value.categoriesList[index].thumb ?? '',
                  keys: value.categoriesList[index].key ?? '',
                  times: value.categoriesList[index].times ?? '',
                  portion: value.categoriesList[index].portion ?? '',
                  dificulty: value.categoriesList[index].dificulty ?? '',
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 4.0);
              },
              itemCount: value.categoriesList.length,
            ),
          );
        },
      ),
    );
  }
}
