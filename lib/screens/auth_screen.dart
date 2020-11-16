import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/todo_list_screen.dart';
import 'package:todo_app_with_flutter_and_firebase/service/auth_service.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
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
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passwordController,
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
                      bool shouldNavigate = await AuthService.login(
                          emailController.text, passwordController.text);
                      if (shouldNavigate) {
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
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text("Signup"),
                    onPressed: () async {
                      bool isRegistered = await AuthService.register(
                          emailController.text, passwordController.text);
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
    );
  }
}
