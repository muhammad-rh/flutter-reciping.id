import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/profile/profile_edit_screen.dart';
import 'package:flutter_mini_project/services/auth_service.dart';
import 'package:flutter_mini_project/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final occupationController = TextEditingController();
  final cityController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    occupationController.dispose();
    cityController.dispose();
    super.dispose();
  }

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
    final manager = Provider.of<AuthServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 215, 14, 14),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(
                      milliseconds: 500,
                    ),
                    reverseTransitionDuration: const Duration(
                      milliseconds: 500,
                    ),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return ProfileEditScreen(manager: manager);
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final tween = Tween(begin: 0.0, end: 1.0);
                      return FadeTransition(
                        opacity: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<AuthServices>(context, listen: false).retrieveUser();
        },
        child: Consumer<AuthServices>(
          builder: (context, value, child) {
            emailController.text = value.loggedInUser.email!;
            firstNameController.text = value.loggedInUser.firstName!;
            lastNameController.text = value.loggedInUser.lastName!;

            if (value.loggedInUser.occupation != '' ||
                value.loggedInUser.occupation == null) {
              occupationController.text = value.loggedInUser.occupation!;
            } else {
              occupationController.text = 'Empty';
            }

            if (value.loggedInUser.city != '' ||
                value.loggedInUser.city == null) {
              cityController.text = value.loggedInUser.city!;
            } else {
              cityController.text = 'Empty';
            }

            return Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 100,
                          child: value.loggedInUser.imgUrl != null
                              ? ClipOval(
                                  child: Image.network(
                                    value.loggedInUser.imgUrl!,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                )
                              : CircleAvatar(
                                  child: Text(
                                    '${value.loggedInUser.firstName?[0].toUpperCase()}${value.loggedInUser.lastName?[0].toUpperCase()}',
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  radius: 50,
                                  backgroundColor:
                                      const Color.fromRGBO(251, 192, 45, 1),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            TextFormField(
                              autofocus: false,
                              readOnly: true,
                              controller: emailController,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                labelText: "Email",
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              autofocus: false,
                              readOnly: true,
                              controller: firstNameController,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                labelText: "First Name",
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              autofocus: false,
                              readOnly: true,
                              controller: lastNameController,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                labelText: "Last Name",
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              autofocus: false,
                              readOnly: true,
                              controller: occupationController,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                labelText: "Occupation",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              autofocus: false,
                              readOnly: true,
                              controller: cityController,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                labelText: "City",
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(18),
                              color: const Color.fromARGB(255, 215, 14, 14),
                              child: MaterialButton(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                minWidth:
                                    (MediaQuery.of(context).size.width * 0.85),
                                onPressed: () {
                                  value.signOut(context);
                                },
                                child: const Text(
                                  'Sign Out',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        isHome: false,
        isSearch: false,
        isArticle: false,
        isProfil: true,
      ),
    );
  }
}
