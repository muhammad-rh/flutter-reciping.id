import 'package:flutter/material.dart';
import 'package:flutter_mini_project/services/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var heightScreen = mediaQueryData.size.height;
    final manager = Provider.of<AuthServices>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
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
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Text(
                          'Already joined us before / ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return ("First Name cannot be Empty");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid name(Min. 3 Character)");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        firstNameController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Enter your First Name here!",
                        labelText: "First Name",
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
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Last Name cannot be Empty");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        lastNameController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Enter your Last Name here!",
                        labelText: "Last Name",
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
                    const SizedBox(height: 20),
                    TextFormField(
                      autofocus: false,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please Enter Your Email");
                        }
                        // reg expression for email validation
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                        hintText: "Enter your Email here!",
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
                    const SizedBox(height: 20),
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
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Enter your Password here!",
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
                    const SizedBox(height: 20),
                    TextFormField(
                      autofocus: false,
                      controller: confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (confirmPasswordController.text !=
                            passwordController.text) {
                          return "Password don't match";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        confirmPasswordController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Enter your Confirm Password here!",
                        labelText: "Confirm Password",
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
                    const SizedBox(height: 20),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(18),
                      color: const Color.fromARGB(255, 215, 14, 14),
                      child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            manager.createUserWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                              firstNameController.text,
                              lastNameController.text,
                              context,
                            );
                          }
                        },
                        child: const Text(
                          'Continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      children: const [
                        Text(
                          "By signing up, you're agree to our ",
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          'Terms & Conditions ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color.fromARGB(255, 215, 14, 14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "and ",
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          'Privacy Policy',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color.fromARGB(255, 215, 14, 14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
