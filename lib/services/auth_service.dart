import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthServices extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  final _collections = FirebaseFirestore.instance.collection('users');

  String? errorMessage;

  UserModel loggedInUser = UserModel();

  UserModel userModel = UserModel();

  UserModel? _userFromFirebase(User? users) {
    return users != null ? UserModel(uid: users.uid) : null;
  }

  Stream<UserModel?> get userNow {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  retrieveUser() async {
    User? user = _auth.currentUser;
    try {
      return await _collections.doc(user!.uid).get().then((value) {
        loggedInUser = UserModel.fromMap(value.data());
      });
    } catch (e) {
      return null;
    }
  }

  void signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) => {
              Fluttertoast.showToast(msg: "Login Successful"),
              Navigator.pushReplacementNamed(context, '/home'),
            },
          );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Your email addres appears to be malformed.";
          break;

        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;

        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;

        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;

        case "too-many-requests":
          errorMessage = "Too many requests.";
          break;

        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;

        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
    }
  }

  void createUserWithEmailAndPassword(
    String email,
    String password,
    String firstName,
    String lastName,
    BuildContext context,
  ) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {
                postDetailsToFirestore(
                  firstName,
                  lastName,
                  null,
                  context,
                  false,
                )
              })
          .catchError(
        (e) {
          Fluttertoast.showToast(msg: e!.message);
        },
      );
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  postDetailsToFirestore(String firstNameController, String lastNameController,
      File? _image, BuildContext context, bool isUpdate) async {
    User? user = _auth.currentUser;

    final String? imgUrl;

    if (_image == null) {
      imgUrl = null;
    } else {
      imgUrl = await uploadImage(_image);
    }

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController;
    userModel.lastName = lastNameController;
    userModel.imgUrl = imgUrl;

    if (isUpdate) {
      await _collections
          .doc(user.uid)
          .set(userModel.toMap(), SetOptions(merge: true));

      Fluttertoast.showToast(msg: "Account updated succesfully :)");
      Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
    } else {
      await _collections.doc(user.uid).set(userModel.toMap());

      Fluttertoast.showToast(msg: "Account created succesfully :)");
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }

  Future<String> uploadImage(File? _image) async {
    final ref =
        FirebaseStorage.instance.ref().child('userImages/${_image!.path}');
    final uploadTask = ref.putFile(_image);

    var downUrl = await (await uploadTask).ref.getDownloadURL();
    var url = downUrl.toString();

    return url;
  }
}
