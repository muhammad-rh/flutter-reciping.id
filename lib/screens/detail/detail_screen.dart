import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/screens/detail/detail_view_model.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String keys;
  const DetailScreen({
    Key? key,
    required this.keys,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Provider.of<DetailViewModel>(context, listen: false)
            .getDetailList(widget.keys);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<DetailViewModel>(context, listen: false)
              .getDetailList(widget.keys);
        },
        child: Consumer<DetailViewModel>(
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

            return SafeArea(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            value.detailList?.thumb ?? '',
                            height: 225,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        Positioned(
                          left: 8.0,
                          top: 8.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const CircleAvatar(
                              child: Icon(
                                Icons.arrow_back_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8.0,
                          top: 8.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const CircleAvatar(
                              child: Icon(
                                Icons.bookmark_border_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8.0,
                          bottom: 8.0,
                          child: Text(
                            '${value.detailList?.author?.user!} | ${value.detailList?.author?.datePublished!}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            value.detailList?.title ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer_sharp,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    value.detailList?.times! ?? '',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.palette_rounded,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    value.detailList?.servings! ?? '',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.https_sharp,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    value.detailList?.dificulty! ?? '',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                                    indicatorColor: Colors.orange,
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
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5),
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
                                              final String item = value
                                                      .detailList
                                                      ?.ingredient![index] ??
                                                  '';
                                              return Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.justify,
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(height: 6);
                                            },
                                            itemCount: value.detailList
                                                    ?.ingredient?.length ??
                                                0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 290,
                                        child: Scrollbar(
                                          child: ListView.separated(
                                            padding: const EdgeInsets.all(4),
                                            itemBuilder: (context, index) {
                                              final String item = value
                                                      .detailList
                                                      ?.step![index] ??
                                                  '';
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
                                            itemCount: value
                                                    .detailList?.step?.length ??
                                                0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Scrollbar(
                                          child: SingleChildScrollView(
                                            child: Text(
                                              '\t\t\t\t\t\t\t${value.detailList?.desc!}',
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
