import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/services/auth_service.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:flutter_mini_project/widgets/notch_navbar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Provider.of<AuthServices>(context, listen: false).retrieveUser();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<AuthServices>(context, listen: false).retrieveUser();
        },
        child: SafeArea(
          child: Center(
            child: Consumer<AuthServices>(
              builder: (context, value, child) {
                // if (value.dataState == DataState.loading) {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }

                // if (value.dataState == DataState.error) {
                //   return const Center(
                //     child: Text('Something went wrong'),
                //   );
                // }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 120,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 60,
                        ),
                        radius: 45,
                      ),
                    ),
                    Text(
                      '${value.loggedInUser.firstName} ${value.loggedInUser.lastName}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${value.loggedInUser.email}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ActionChip(
                      label: const Text('Logout'),
                      onPressed: () {
                        value.signOut(context);
                      },
                    ),
                    ActionChip(
                      label: const Text('Edit'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/update');
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: const NotchNavBar(isAdd: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(
        isHome: false,
        isSearch: false,
        isBookmark: false,
        isProfil: true,
      ),
    );
  }

  // Future<void> logout(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.pushReplacementNamed(context, '/login');
  // }
}
