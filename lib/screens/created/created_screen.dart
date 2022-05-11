import 'package:flutter/material.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/notch_navbar.dart';

class CreatedScreen extends StatefulWidget {
  const CreatedScreen({Key? key}) : super(key: key);

  @override
  State<CreatedScreen> createState() => _CreatedScreenState();
}

class _CreatedScreenState extends State<CreatedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Bookmark',
          ),
        ),
      ),
      floatingActionButton: const NotchNavBar(isAdd: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(
        isHome: false,
        isSearch: false,
        isBookmark: true,
        isProfil: false,
      ),
    );
  }
}
