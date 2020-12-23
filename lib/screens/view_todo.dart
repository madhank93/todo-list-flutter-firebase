import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';

class ViewTodo extends StatelessWidget {
  final Todo todo;

  ViewTodo(this.todo);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("View todo"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  maxLines: null,
                  initialValue: todo.todoTitle,
                  obscureText: false,
                  readOnly: true,
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
                    labelText: "Title",
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
                  maxLines: null,
                  //initialValue: todo.todoDescription,
                  obscureText: false,
                  readOnly: true,
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
                    labelText: "Description",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.black,
                    filled: true,
                    contentPadding: EdgeInsets.all(14),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
