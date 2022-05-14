import 'package:flutter/material.dart';
import 'package:flutter_mini_project/services/auth_service.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
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
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
        await Provider.of<AuthServices>(context, listen: false).retrieveUser();
        setState(() {});
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 90,
                      child: value.loggedInUser.imgUrl != null
                          ? ClipOval(
                              child: Image.network(
                                value.loggedInUser.imgUrl!,
                                fit: BoxFit.cover,
                                width: 90,
                                height: 90,
                              ),
                            )
                          : CircleAvatar(
                              child: Text(
                                '${value.loggedInUser.firstName?[0].toUpperCase()}${value.loggedInUser.lastName?[0].toUpperCase()}',
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
