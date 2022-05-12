import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthServices extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  DataState dataState = DataState.loading;

  UserModel? _userFromFirebase(User? users) {
    return users != null ? UserModel(uid: users.uid) : null;
  }

  Stream<UserModel?> get userNow {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void retrieveUser() async {
    changeState(DataState.loading);
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());
        changeState(DataState.filled);
      });
    } catch (e) {
      print('Error retrieved user: $e');
      changeState(DataState.error);
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
      print(e.code);
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
          .then(
              (value) => {postDetailsToFirestore(firstName, lastName, context)})
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
      print(error.code);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  postDetailsToFirestore(String firstNameController, String lastNameController,
      BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController;
    userModel.lastName = lastNameController;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created succesfully :)");
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}
