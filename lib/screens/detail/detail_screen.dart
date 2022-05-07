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
      appBar: AppBar(
        title: const Text(
          'Recipe Detail',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<DetailViewModel>(context, listen: false)
              .getDetailList(widget.keys);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
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

              return SizedBox(
                child: Column(
                  children: [
                    Text(value.detailList?.title ?? ''),
                    Text(value.detailList?.servings ?? ''),
                    SizedBox(
                      height: 500,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final String item =
                              value.detailList?.ingredient![index] ?? '';
                          return Text(
                            item,
                            textAlign: TextAlign.justify,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 4);
                        },
                        itemCount: value.detailList?.ingredient?.length ?? 0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
