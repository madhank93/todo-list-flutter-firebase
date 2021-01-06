import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/add_todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/auth_service.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';
import 'edit_todo.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  int backPressCounter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Todo list"),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.login,
                  color: Colors.redAccent,
                ),
                onPressed: () => AuthService.logout(),
              )
            ],
          ),
          body: getTodoListBody(context),
          bottomNavigationBar: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodo(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getTodoListBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TodoService().getTodoListOfCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Widget child;
        if (snapshot.hasError) {
          child = Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          child = Center(
            child: Text(
              "Loading",
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.data.size == 0) {
          child = Center(
            child: Text("All TODOs are caught up"),
          );
        } else if (snapshot.hasData && snapshot.data.size > 0) {
          child = Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Todo todo = Todo.fromJson(snapshot.data.docs[index].data());
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  actions: [
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTodo(todo),
                          ),
                        )
                      },
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => {TodoService().deleteByID(todo.uuid)},
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Card(
                      child: ExpansionTile(
                        title: Text(
                          todo.todoTitle,
                          style: TextStyle(color: Colors.white),
                          maxLines: 2,
                        ),
                        children: todo.taskList
                            .asMap()
                            .entries
                            .map(
                              (task) => CheckboxListTile(
                                contentPadding: EdgeInsets.only(left: 30),
                                value: task.value.status,
                                title: Text(task.value.taskDescription),
                                onChanged: (value) {
                                  print(value);
                                  setState(
                                    () {
                                      task.value.status = value;
                                      TodoService()
                                          .updateByID(todo.toJson(), todo.uuid);
                                    },
                                  );
                                },
                              ),
                            )
                            .toList(),
                        trailing: Icon(Icons.keyboard_arrow_down),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return child;
      },
    );
  }

  Future<bool> onWillPop() {
    if (backPressCounter < 1) {
      backPressCounter++;
      Fluttertoast.showToast(msg: "Press again to exit !!!");
      Future.delayed(Duration(seconds: 2, milliseconds: 0), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
