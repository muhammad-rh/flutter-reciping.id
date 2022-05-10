import 'package:flutter/material.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/notch_navbar.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            widget.search,
          ),
        ),
      ),
      floatingActionButton: const NotchNavBar(isAdd: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(
        isHome: false,
        isSearch: true,
        isBookmark: false,
        isProfil: false,
      ),
    );
  }
}
