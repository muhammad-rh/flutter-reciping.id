import 'package:flutter/material.dart';
import 'package:flutter_mini_project/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var heightScreen = mediaQueryData.size.height;
    final manager = Provider.of<AuthServices>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: heightScreen),
                child: Container(
                  padding: const EdgeInsets.all(28),
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Image(
                            image: AssetImage('assets/icon_login.jpg'),
                            height: 320,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Hey,\nLogin Now.',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text(
                              'If you are new / ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: const Text(
                                'Create New',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          autofocus: false,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
                            }
                            // reg expression
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Enter your email",
                            labelText: "Email",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black38,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black38,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(251, 192, 45, 1),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          autofocus: false,
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Enter your password",
                            labelText: "Password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black38,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black38,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(251, 192, 45, 1),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(18),
                          color: const Color.fromARGB(255, 215, 14, 14),
                          child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                manager.signInWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                  context,
                                );
                              }
                            },
                            child: const Text(
                              'Login',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
