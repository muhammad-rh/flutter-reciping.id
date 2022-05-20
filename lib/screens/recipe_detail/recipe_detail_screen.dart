import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/recipe_detail.dart';
import 'package:flutter_mini_project/screens/favourite/favourite_view_model.dart';
import 'package:flutter_mini_project/screens/recipe_detail/recipe_detail_view_model.dart';
import 'package:flutter_mini_project/widgets/shimmer_detail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String secondThumb;
  final String keys;
  const RecipeDetailScreen({
    Key? key,
    required this.secondThumb,
    required this.keys,
  }) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreen();
}

class _RecipeDetailScreen extends State<RecipeDetailScreen> {
  @override
  void initState() {
    super.initState();

    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Provider.of<RecipeDetailViewModel>(context, listen: false)
            .getRecipeDetailList(widget.keys);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<FavouriteViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail',
        ),
        backgroundColor: const Color.fromARGB(255, 215, 14, 14),
      ),
      body: Consumer<RecipeDetailViewModel>(
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
            padding: const EdgeInsets.all(8),
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
                            image: (value.detailList?.thumb != null)
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
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Text(
                          '${value.detailList?.author?.user} | ${value.detailList?.author?.datePublished}',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: () {
                            final list = RecipeDetail(
                              title: value.detailList?.title,
                              thumb: widget.secondThumb,
                              servings: value.detailList?.servings,
                              times: value.detailList?.times,
                              dificulty: value.detailList?.dificulty,
                              author: value.detailList?.author,
                              desc: value.detailList?.desc,
                              needItem: value.detailList?.needItem,
                              ingredient: value.detailList?.ingredient,
                              step: value.detailList?.step,
                              isFav: value.detailList?.isFav,
                              id: widget.keys,
                            );

                            manager.isFavourited(list);
                          },
                          child: const Icon(
                            Icons.favorite,
                            size: 40,
                            color: Color.fromARGB(255, 215, 14, 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        value.detailList?.title ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SizedBox(
                            child: Image.asset(
                              'assets/time.png',
                              height: 18,
                              width: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Cooking Time : ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            value.detailList!.times!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Image.asset(
                            'assets/portion.png',
                            height: 18,
                            width: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Servings : ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            value.detailList!.servings!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Image.asset(
                            'assets/difficulty.png',
                            height: 18,
                            width: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Difficulty : ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            value.detailList!.dificulty!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        child: TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Color.fromARGB(255, 215, 14, 14),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: [
                            Tab(
                              text: 'Ingredients',
                            ),
                            Tab(
                              text: 'Step',
                            ),
                            Tab(
                              text: 'Desc',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 330,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        child: TabBarView(
                          children: [
                            SizedBox(
                              height: 250,
                              child: Scrollbar(
                                child: ListView.separated(
                                  padding: const EdgeInsets.all(4),
                                  itemBuilder: (context, index) {
                                    final String item =
                                        value.detailList?.ingredient![index] ??
                                            '';
                                    return Text(
                                      '\u2022 $item',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.justify,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 6);
                                  },
                                  itemCount:
                                      value.detailList?.ingredient?.length ?? 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 290,
                              child: Scrollbar(
                                child: ListView.separated(
                                  padding: const EdgeInsets.all(4),
                                  itemBuilder: (context, index) {
                                    final String item =
                                        value.detailList?.step![index] ?? '';
                                    return Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.justify,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 4);
                                  },
                                  itemCount:
                                      value.detailList?.step?.length ?? 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '\t\t\t\t\t\t\t${value.detailList?.desc}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
