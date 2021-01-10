import 'dart:async';
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
      bool isLinkVerified = await AuthService.checkEmailHasBeenVerified();
      if (isLinkVerified) {
        _timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TodoListScreen(),
            settings: RouteSettings(name: '/todo_list'),
          ),
        );
      }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                  text: "An email has been sent to the address ",
                  children: [
                    TextSpan(
                      text: "${AuthService.user.email}",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                    TextSpan(text: " please click on the link to verify it.")
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
