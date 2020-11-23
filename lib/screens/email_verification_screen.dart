import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/todo_list_screen.dart';
import 'package:todo_app_with_flutter_and_firebase/service/auth_service.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await AuthService.checkEmailHasBeenVerified();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "An email has been sent to the address ${AuthService.user.email}",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Future<void> checkEmailHasBeenVerified() async {
  //   User user = AuthService.user;
  //   await user.reload();
  //   print(user.emailVerified);
  //   if (user.emailVerified) {
  //     _timer.cancel();
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => TodoListScreen(),
  //       ),
  //     );
  //   }
  // }
}
