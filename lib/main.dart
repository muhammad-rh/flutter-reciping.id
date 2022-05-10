import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/detail/detail_view_model.dart';
import 'package:flutter_mini_project/screens/home/home_screen.dart';
import 'package:flutter_mini_project/screens/home/home_view_model.dart';
import 'package:flutter_mini_project/screens/main/main_screen.dart';
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
