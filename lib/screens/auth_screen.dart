import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/email_verification_screen.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/todo_list_screen.dart';
import 'package:todo_app_with_flutter_and_firebase/service/auth_service.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/custom_raised_button.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/custom_text_field.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistered = false;
  bool shouldNavigate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                  labelText: "Email or Phone number",
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
                      textLabel: "Login",
                      onPressedExecution: onLogin,
                    ),
                    CustomRaisedButton(
                      textLabel: "Signup",
                      onPressedExecution: onSignup,
                    )
                  ],
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

  void onLogin() async {
    if (_formKey.currentState.validate()) {
      shouldNavigate = await AuthService.loginWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    }
    if (shouldNavigate) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => TodoListScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  void onSignup() async {
    if (_formKey.currentState.validate()) {
      isRegistered = await AuthService.registerWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    }
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
