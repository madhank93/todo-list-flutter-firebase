import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Todo"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _title,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: null,
                    inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _description,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: null,
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter description';
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
                        onPressed: () => submit(context),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.greenAccent)),
                      ),
                      RaisedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.redAccent)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  submit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      Todo todo = new Todo();
      todo.status = false;
      todo.todoTitle = _title.text;
      todo.todoDescription = _description.text;
      TodoService().add(todo.toJson());
      Navigator.pop(context);
    }
  }
}
