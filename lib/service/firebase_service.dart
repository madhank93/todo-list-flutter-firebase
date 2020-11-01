import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference getCollectionRef() {
    throw new Exception("Collection reference should be implemented by subclass");
  }

  add(data) async {
    return await this.getCollectionRef().add(data);
  }
}