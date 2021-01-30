import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/login_screen.dart';
import 'package:todo_app_with_flutter_and_firebase/service/auth_service.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/custom_raised_button.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/custom_text_field.dart';

import 'email_verification_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistered = false;
  bool shouldNavigate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  editingController: _emailController,
                  isObscure: false,
                  labelText: "Email",
                  textFieldValidator: emailValidation,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  editingController: _passwordController,
                  isObscure: true,
                  labelText: "Password",
                  textFieldValidator: passwordValidation,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomRaisedButton(
                      textLabel: "Signup",
                      onPressedExecution: onSignup,
                    )
                  ],
                ),
                Text.rich(
                  TextSpan(
                    text: "Already have an account ? ",
                    children: [
                      TextSpan(
                        text: 'Signin',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                                settings: RouteSettings(name: '/login'),
                              ),
                            );
                          },
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String emailValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter email';
    }
    return null;
  }

  String passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  void onSignup() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    isRegistered = await AuthService.registerWithEmailAndPassword(_emailController.text, _passwordController.text);
    if (isRegistered) {
      await AuthService.sendEmailVerificationToRegisteredMail();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailVerificationScreen(),
        ),
      );
    }
  }
}
