import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/article/article_view_model.dart';
import 'package:flutter_mini_project/screens/article_detail/article_detail_view_model.dart';
import 'package:flutter_mini_project/screens/favourite/favourite_view_model.dart';
import 'package:flutter_mini_project/screens/home/home_screen.dart';
import 'package:flutter_mini_project/screens/home/home_view_model.dart';
import 'package:flutter_mini_project/screens/login/login_screen.dart';
import 'package:flutter_mini_project/screens/profile/profile_screen.dart';
import 'package:flutter_mini_project/screens/recipe_detail/recipe_detail_view_model.dart';
import 'package:flutter_mini_project/screens/register/register_screen.dart';
import 'package:flutter_mini_project/screens/splash/splash_screen.dart';
import 'package:flutter_mini_project/services/auth_service.dart';
import 'package:flutter_mini_project/widgets/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => RecipeDetailViewModel()),
        ChangeNotifierProvider(create: (_) => ArticleViewModel()),
        ChangeNotifierProvider(create: (_) => ArticleDetailViewModel()),
        ChangeNotifierProvider(create: (_) => FavouriteViewModel()),
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
        routes: {
          '/': (context) => const SplashScreen(),
          '/wrapper': (context) => const Wrapper(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    ),
  );
}
