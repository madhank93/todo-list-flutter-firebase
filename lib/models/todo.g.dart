// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo()
    //..uuid = json['uuid'] as String
    ..todoTitle = json['todo_title'] as String
    ..todoDescription = json['todo_description'] as String
    ..status = json['status'] as bool;
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      //'uuid': instance.uuid,
      'todo_title': instance.todoTitle,
      'todo_description': instance.todoDescription,
      'status': instance.status,
    };
