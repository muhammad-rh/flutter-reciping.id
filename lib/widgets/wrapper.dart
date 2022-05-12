import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/user.dart';
import 'package:flutter_mini_project/screens/home/home_screen.dart';
import 'package:flutter_mini_project/screens/login/login_screen.dart';
import 'package:flutter_mini_project/services/auth_service.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    return StreamBuilder<UserModel?>(
      stream: authService.userNow,
      builder: (_, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserModel? user = snapshot.data;
          return user == null ? const LoginScreen() : const HomeScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
