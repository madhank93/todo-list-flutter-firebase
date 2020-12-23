// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task()
    ..taskDescription = json['task_description'] as String
    ..status = json['status'] as bool ?? false;
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'task_description': instance.taskDescription,
      'status': instance.status,
    };
