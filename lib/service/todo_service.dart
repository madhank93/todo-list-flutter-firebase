import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_with_flutter_and_firebase/models/users.dart';
import 'package:todo_app_with_flutter_and_firebase/service/firebase_service.dart';

class TodoService extends FirebaseService {
  TodoService();

  CollectionReference getCollectionRef() {
    return FirebaseService.db
        .collection("user")
        .doc(Users().getID())
        .collection("todo");
  }

  Stream<QuerySnapshot> getTodoListOfCurrentUser() {
    return getCollectionRef().snapshots();
  }
}
