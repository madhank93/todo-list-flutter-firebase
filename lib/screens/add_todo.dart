import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: _title,
            obscureText: false,
            textAlign: TextAlign.start,
            maxLines: 2,
            autofocus: false,
            cursorColor: Colors.orange,
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
            controller: _description,
            obscureText: false,
            textAlign: TextAlign.start,
            maxLines: 3,
            autofocus: false,
            cursorColor: Colors.orange,
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
          RaisedButton(onPressed: () => submit())
        ],
      ),
    );
  }

  submit() {
    Todo todo = new Todo();
    //todo.uuid = "test";
    todo.status = false;
    todo.todoTitle = _title.text;
    todo.todoDescription = _description.text;
    TodoService().add(todo.toJson());
  }
}
