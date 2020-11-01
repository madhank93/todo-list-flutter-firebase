import 'package:json_annotation/json_annotation.dart';
part 'todo.g.dart';

@JsonSerializable(nullable: false)
class Todo {
  //@JsonKey(name: 'uuid', nullable: false)
  //String uuid;

  @JsonKey(name: "todo_title", nullable: false)
  String todoTitle;

  @JsonKey(name: "todo_description", nullable: false)
  String todoDescription;

  @JsonKey(name: "status", nullable: false)
  bool status;

  Todo();

  factory Todo.fromJson(Map<String, dynamic> data) => _$TodoFromJson(data);

  Map<String,dynamic> toJson() => _$TodoToJson(this);

}
