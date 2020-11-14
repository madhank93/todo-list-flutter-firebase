import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';

class EditTodo extends StatefulWidget {
  final Todo todo;

  EditTodo(this.todo);

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  String _title = "";
  String _description = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _title = widget.todo.todoTitle;
    _description = widget.todo.todoDescription;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Todo"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: _title,
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
                  validator: (title) {
                    if (title.isEmpty) {
                      return "Must not be empty";
                    } else {
                      this._title = title;
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: _description,
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
                  validator: (description) {
                    if (description.isEmpty) {
                      return "Must not be empty";
                    } else {
                      this._description = description;
                      return null;
                    }
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
    );
  }

  submit(BuildContext context) {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      Todo todo = new Todo();
      todo.status = false;
      todo.todoTitle = _title;
      todo.todoDescription = _description;
      TodoService().updateByID(todo.toJson(), widget.todo.uuid);
      Navigator.pop(context);
    }
  }
}
