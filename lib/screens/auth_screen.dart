import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/todo_list_screen.dart';
import 'package:todo_app_with_flutter_and_firebase/service/auth_service.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                TextFormField(
                  controller: _emailController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  autofocus: false,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: "Email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.black,
                    filled: true,
                    contentPadding: EdgeInsets.all(14),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  textAlign: TextAlign.start,
                  autofocus: false,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                      ),
                    ),
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.black,
                    filled: true,
                    contentPadding: EdgeInsets.all(14),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("Login"),
                      onPressed: () async {
                        bool shouldNavigate = false;
                        if (_formKey.currentState.validate()) {
                          shouldNavigate = await AuthService.login(
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
                      },
                      color: Colors.blue,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("Signup"),
                      onPressed: () async {
                        bool isRegistered = await AuthService.register(
                            _emailController.text, _passwordController.text);
                        if (isRegistered) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TodoListScreen(),
                            ),
                          );
                        }
                      },
                      color: Colors.blue,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
