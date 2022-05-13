import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/created/created_list_screen.dart';
import 'package:flutter_mini_project/utils/db_manager.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/empty_screen.dart';
import 'package:flutter_mini_project/widgets/notch_navbar.dart';
import 'package:provider/provider.dart';

class CreatedScreen extends StatelessWidget {
  const CreatedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildRecipeScreen(),
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

  Widget buildRecipeScreen() {
    return Consumer<DbManager>(
      builder: (context, manager, child) {
        if (manager.recipeList.isNotEmpty) {
          return CreatedListScreen(
            manager: manager,
          );
        } else {
          return const EmptyScreen();
        }
      },
    );
  }
}
