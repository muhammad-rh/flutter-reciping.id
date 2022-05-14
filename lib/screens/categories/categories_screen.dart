import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/categories/categories_view_model.dart';
import 'package:flutter_mini_project/screens/detail/detail_screen.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/catagories_list.dart';
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
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: const Color.fromARGB(255, 215, 14, 14),
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
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                if (isFound == true) {
                  return SearchRecipeCard(
                    title: value.recipeList[index].title ?? 'Untitle',
                    thumb: value.recipeList[index].thumb ?? '',
                    keys: value.recipeList[index].key ?? '',
                    times: value.recipeList[index].times ?? '',
                    portion: value.recipeList[index].portion ?? '',
                    dificulty: value.recipeList[index].dificulty ?? '',
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
