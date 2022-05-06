import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/main/main_screen.dart';
import 'package:flutter_mini_project/screens/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecipeViewModel(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Recipe',
        home: MainScreen(),
      ),
    ),
  );
}
