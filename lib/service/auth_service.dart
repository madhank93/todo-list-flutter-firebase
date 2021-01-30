import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;
  static User user = auth.currentUser;

  // Sign-in process
  static Future<bool> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email' || error.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "The username or password is invalid.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      } else if (error.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "The user not found.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    }
  }

  // Sign-up process
  static Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: "The password provided is too weak.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      } else if (error.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "Entered email already in use",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      } else if (error.code == 'invalid-email') {
        Fluttertoast.showToast(
          msg: "Invalid email",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    }
  }

  // Send verification email process
  static Future<void> sendEmailVerificationToRegisteredMail() async {
    try {
      await user.sendEmailVerification();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  // Verifies user's email ID by checking email verification link has been clicked
  static Future<bool> checkEmailHasBeenVerified() async {
    await user.reload();
    user = auth.currentUser;
    if (user.emailVerified)
      return true;
    else
      return false;
  }

  static Future<void> logout () async{
    return auth.signOut();
  }

}
