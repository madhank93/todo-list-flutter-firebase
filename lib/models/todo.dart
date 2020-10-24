import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app_with_flutter_and_firebase/models/model.dart';

@JsonSerializable(nullable: false)
class Todo extends Model {
  static CollectionReference _todoCollectionReference =
      Model.db.collection("todo");

  @JsonKey(name: 'uuid', nullable: false)
  String uuid;
  
  @JsonKey(name: "todoTitle", nullable: false)
  String todoTitle;

  @JsonKey(name: "todoDescription", nullable: false)
  String todoDescription;

  @JsonKey(name: "status", nullable: false)
  bool status;

  Todo();

  CollectionReference getCollectionRef() {
    return _todoCollectionReference;
  }

  String getID() {
    return this.uuid;
  }
}
