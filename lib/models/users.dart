import 'package:firebase_auth/firebase_auth.dart';

class Users {
  Users();
  String getID() {
    return FirebaseAuth.instance.currentUser.uid;
  }
}
