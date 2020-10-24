import 'package:cloud_firestore/cloud_firestore.dart';

class Model{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference getCollectionRef() {
    throw new Exception("Collection reference should be implemented by subclass");
  }

  String getID() {
    throw new Exception("ID should be implemented by subclass");
  }

  add(Map<String,dynamic> data) async {
    return await this.getCollectionRef().document(this.getID()).setData(data);
  }
}