import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/article/article_view_model.dart';
import 'package:flutter_mini_project/widgets/article_list_card.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/shimmer_categories_list.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void initState() {
    super.initState();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (timeStamp) {
          Provider.of<ArticleViewModel>(context, listen: false)
              .getArticleList('makanan-gaya-hidup');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        backgroundColor: const Color.fromARGB(255, 215, 14, 14),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<ArticleViewModel>(context, listen: false);
        },
        child: Column(
          children: [
            Expanded(
              child: articleList(),
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

  SizedBox articleList() {
    return SizedBox(
      child: Consumer<ArticleViewModel>(
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

          return Scrollbar(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ArticleListCard(
                  title: value.articleList[index].title!,
                  thumb: value.articleList[index].thumb!,
                  keys: value.articleList[index].key!,
                  tags: value.articleList[index].tags!,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 4.0);
              },
              itemCount: value.articleList.length,
            ),
          );
        },
      ),
    );
  }
}
