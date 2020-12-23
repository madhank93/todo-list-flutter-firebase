import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_with_flutter_and_firebase/models/task.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<Task> _taskList = [Task.fromJson({}), Task.fromJson({})];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Todo"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.save,
                size: 35,
              ),
              color: Colors.greenAccent,
              onPressed: () => submit(context),
            ),
            IconButton(
              icon: Icon(
                Icons.cancel,
                size: 35,
              ),
              color: Colors.redAccent,
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 10),
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
                  _taskList.length == 1
                      ? Row(
                          children: [
                            Flexible(
                              child: TextFormField(
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
                                  labelText: "Task 1",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  fillColor: Colors.black,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(14),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter task';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.greenAccent,
                                ),
                                onPressed: () {})
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _taskList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _description,
                                      obscureText: false,
                                      textAlign: TextAlign.start,
                                      maxLines: null,
                                      autofocus: false,
                                      cursorColor: Colors.blue,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        labelText: "Task ${index + 1}",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        fillColor: Colors.black,
                                        filled: true,
                                        contentPadding: EdgeInsets.all(14),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter task';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () {})
                                ],
                              ),
                            );
                          },
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
      todo.todoTitle = _title.text;
      TodoService().add(todo.toJson());
      Navigator.pop(context);
    }
  }
}
