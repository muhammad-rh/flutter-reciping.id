// import 'package:flutter/material.dart';
// import 'package:flutter_internship/models/guest.dart';
// import 'package:flutter_internship/screens/main_screen.dart';

// class LoginScreen extends StatelessWidget {
//   final Function(Guest) onCreate;
//   LoginScreen({
//     Key? key,
//     required this.onCreate,
//   }) : super(key: key);

//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 50),
              // const Text(
              //   'Hey,\nLogin Now.',
              //   style: TextStyle(
              //     fontSize: 28,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
//               Expanded(
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(
//                         children: const [
//                           Text(
//                             'If you are new / ',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             'Create New',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12.0),
//                           color: const Color.fromARGB(255, 230, 231, 235),
//                         ),
//                         child: TextFormField(
//                           controller: usernameController,
//                           decoration: const InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.person,
//                               size: 30,
//                               color: Colors.black,
//                             ),
//                             hintText: 'Username',
//                             hintStyle: TextStyle(
//                               fontSize: 18,
//                               color: Colors.black54,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.transparent),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.transparent),
//                             ),
//                           ),
//                           style: const TextStyle(fontSize: 18),
//                           validator: (value) {
//                             if (value!.isNotEmpty && value.length > 5) {
//                               return null;
//                             } else if (value.isNotEmpty && value.length < 6) {
//                               return 'Mininum 6 character';
//                             } else {
//                               return 'Fill username field please';
//                             }
//                           },
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12.0),
//                           color: const Color.fromARGB(255, 230, 231, 235),
//                         ),
//                         child: TextFormField(
//                           controller: passwordController,
//                           obscureText: true,
//                           decoration: const InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.key,
//                               size: 28,
//                               color: Colors.black,
//                             ),
//                             hintText: 'Password',
//                             hintStyle: TextStyle(
//                               fontSize: 18,
//                               color: Colors.black54,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.transparent),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.transparent),
//                             ),
//                           ),
//                           style: const TextStyle(fontSize: 18),
//                           validator: (value) {
//                             if (value!.isNotEmpty && value.length > 5) {
//                               return null;
//                             } else if (value.isNotEmpty && value.length < 6) {
//                               return 'Mininum 6 character';
//                             } else {
//                               return 'Fill password field please';
//                             }
//                           },
//                         ),
//                       ),
//                       Row(
//                         children: const [
//                           Text(
//                             'Forgot Password ? / ',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             'Reset',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 45,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (formKey.currentState!.validate()) {
//                               var guest = Guest(
//                                 username: usernameController.text,
//                                 password: passwordController.text,
//                                 fullname: '',
//                                 phone: '',
//                                 bio: '',
//                                 checkFile: false,
//                               );
//                               onCreate(guest);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Login Success'),
//                                 ),
//                               );
//                               Navigator.of(context).push(
//                                 PageRouteBuilder(
//                                   transitionDuration:
//                                       const Duration(milliseconds: 500),
//                                   reverseTransitionDuration:
//                                       const Duration(milliseconds: 500),
//                                   pageBuilder:
//                                       (context, animation, secondaryAnimation) {
//                                     return const MainScreen();
//                                   },
//                                   transitionsBuilder: (context, animation,
//                                       secondaryAnimation, child) {
//                                     final tween2 = Tween(begin: 0.0, end: 1.0);
//                                     return FadeTransition(
//                                       opacity: animation.drive(tween2),
//                                       child: child,
//                                     );
//                                   },
//                                 ),
//                               );
//                             }
//                           },
//                           child: const Text(
//                             'Login',
//                             style: TextStyle(
//                               fontSize: 16,
//                             ),
//                           ),
//                           style: TextButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             primary: Colors.white,
//                             backgroundColor:
//                                 const Color.fromARGB(255, 23, 47, 69),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text(
//                           'Skip Now',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             decoration: TextDecoration.underline,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
