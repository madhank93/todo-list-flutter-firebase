import 'package:json_annotation/json_annotation.dart';
part 'task.g.dart';

@JsonSerializable(nullable: false)
class Task {
  @JsonKey(name: "task_description", nullable: false)
  String taskDescription;

  @JsonKey(name: "status", nullable: true, defaultValue: false)
  bool status;

  Task();

  factory Task.fromJson(Map<String, dynamic> data) => _$TaskFromJson(data);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
