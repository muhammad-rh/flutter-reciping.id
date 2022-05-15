import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/article_detail/article_detail_view_model.dart';
import 'package:flutter_mini_project/widgets/shimmer_detail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String tags;
  final String keys;
  final String secondThumb;
  const ArticleDetailScreen({
    Key? key,
    required this.tags,
    required this.keys,
    required this.secondThumb,
  }) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Provider.of<ArticleDetailViewModel>(context, listen: false)
            .getArticleDetailList(widget.tags, widget.keys);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Article Detail',
        ),
        backgroundColor: const Color.fromARGB(255, 215, 14, 14),
      ),
      body: Consumer<ArticleDetailViewModel>(
        builder: (context, value, child) {
          if (value.dataState == DataState.loading) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade300,
                child: const ShimmerDetail(),
              ),
            );
          }

          if (value.dataState == DataState.error) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            image: (value.detailList!.thumb != null)
                                ? NetworkImage(value.detailList!.thumb!)
                                : NetworkImage(widget.secondThumb),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6),
                              BlendMode.dstATop,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
