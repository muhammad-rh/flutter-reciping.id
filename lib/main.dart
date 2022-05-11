import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/categories/categories_view_model.dart';
import 'package:flutter_mini_project/screens/detail/detail_view_model.dart';
import 'package:flutter_mini_project/screens/home/home_screen.dart';
import 'package:flutter_mini_project/screens/home/home_view_model.dart';
import 'package:flutter_mini_project/screens/search/search_view_model.dart';
import 'package:flutter_mini_project/utils/db_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DbManager(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scrollbarTheme: ScrollbarThemeData(
            thickness: MaterialStateProperty.all(5),
            thumbColor: MaterialStateProperty.all(Colors.blue),
            radius: const Radius.circular(15),
            minThumbLength: 100,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Recipe',
        home: const HomeScreen(),
      ),
    ),
  );
}
