import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/models/todo.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/add_todo.dart';
import 'package:todo_app_with_flutter_and_firebase/service/todo_service.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
    );
  }

  Widget getTodoListBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TodoService().getTodoListOfCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Widget child;
        if (snapshot.hasError) {
          child = Text('Something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          child = Text("Loading");
        } else if (snapshot.hasData) {
          child = ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(
                  document.data()['todo_title'],
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                ),
                subtitle: Text(
                  document.data()['todo_description'],
                  maxLines: 3,
                ),
              );
            }).toList(),
          );
        }
        return child;
      },
    );
  }
}
