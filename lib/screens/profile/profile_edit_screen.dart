import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mini_project/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  File? _image;
  final _picker = ImagePicker();

  Future<void> chooseImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<AuthServices>(context, listen: false);
    emailController.text = manager.loggedInUser.email!;
    firstNameController.text = manager.loggedInUser.firstName!;
    lastNameController.text = manager.loggedInUser.lastName!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(36.0),
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    child: CircleAvatar(
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Text(
                              firstNameController.text[0] +
                                  lastNameController.text[0],
                            ),
                      radius: 45,
                    ),
                  ),
                  TextFormField(
                    autofocus: false,
                    readOnly: true,
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
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.mail,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.account_circle,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                        return ("Second Name cannot be Empty");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      lastNameController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.account_circle,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Last Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.redAccent,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          manager.postDetailsToFirestore(
                            firstNameController.text,
                            lastNameController.text,
                            context,
                            true,
                          );
                        }
                      },
                      child: const Text(
                        'Update',
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
      ),
    );
  }
}
