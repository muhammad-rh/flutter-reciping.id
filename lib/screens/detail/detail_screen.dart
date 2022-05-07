import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/detail/detail_view_model.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final String keys;
  const DetailScreen({
    Key? key,
    required this.keys,
  }) : super(key: key);

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
              .getDetailList(keys);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Center(),
        ),
      ),
    );
  }
}
