// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo()
    ..uuid = json['uuid'] as String
    ..todoTitle = json['todo_title'] as String
    ..taskList = (json['task_list'] as List)
        .map((e) => Task.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'todo_title': instance.todoTitle,
      'task_list': instance.taskList.map((e) => e.toJson()).toList(),
    };
