import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference getCollectionReference() {
    throw new Exception(
        "Collection reference should be implemented by subclass");
  }

  String getID() {
    throw new Exception("ID should be implemented by subclass");
  }

  DocumentReference getDocumentReference(id) {
    return getCollectionReference().doc(id);
  }

  add(Map<String, dynamic> data) async {
    String id = getID();
    data['uuid'] = id;
    data['created_at'] = DateTime.now();
    await getCollectionReference().doc(id).set(data);
  }

  update(Map<String, dynamic> data) async {
    data['updated_at'] = DateTime.now();
    await getDocumentReference(getID()).update(data);
  }

  updateByID(Map<String, dynamic> data, String documentUUID) async {
    data['updated_at'] = DateTime.now();
    data['uuid'] = documentUUID;
    await getDocumentReference(documentUUID).update(data);
  }

  deleteByID(String documentUUID) async{
    await getDocumentReference(documentUUID).delete();
  }

}
