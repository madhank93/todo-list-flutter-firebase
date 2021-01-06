import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app_with_flutter_and_firebase/models/task.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _title = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<Task> _taskList = [Task.fromJson({})];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          label: Text("Add Task"),
          icon: Icon(Icons.add),
          onPressed: () {
            if (_taskList.last.taskDescription == null ||
                _taskList.last.taskDescription.isEmpty) {
              Fluttertoast.showToast(msg: "Please enter task");
            } else {
              setState(
                () {
                  _taskList.add(Task.fromJson({}));
                },
              );
            }
          },
        ),
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
                      ? TextFormField(
                          initialValue: _taskList[0].taskDescription,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: Colors.black,
                            filled: true,
                            contentPadding: EdgeInsets.all(14),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _taskList[0].taskDescription = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter task';
                            }
                            return null;
                          },
                        )
                      : _taskList.length > 1
                          ? ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: _taskList.length,
                              itemBuilder: (BuildContext context, int index) {
                                Task _task = _taskList[index];
                                return Padding(
                                  key: ObjectKey(_task),
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          initialValue:
                                              _taskList[index].taskDescription,
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
                                          onChanged: (value) {
                                            _taskList[index].taskDescription =
                                                value;
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.redAccent,
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {
                                              _taskList.removeAt(index);
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container(),
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
      todo.taskList = _taskList;
      TodoService().add(todo.toJson());
      Navigator.pop(context);
    }
  }
}
