import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/add_todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text("Todo list"),
        ),
        body: getTodoListBody(context),
        bottomNavigationBar: FloatingActionButton(
          backgroundColor: Colors.orange,
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
    );
  }

  Widget getTodoListBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TodoService().getTodoListOfCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Widget child;
        if (snapshot.hasError) {
          child = Text(
            'Something went wrong',
            style: TextStyle(color: Colors.white),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          child = Text(
            "Loading",
            style: TextStyle(color: Colors.white),
          );
        } else if (snapshot.hasData) {
          child = ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  snapshot.data.docs[index]['todo_title'],
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                ),
                subtitle: Text(
                  snapshot.data.docs[index]['todo_description'],
                  maxLines: 3,
                ),
              );
            },
          );
        }
        return child;
      },
    );
  }
}
