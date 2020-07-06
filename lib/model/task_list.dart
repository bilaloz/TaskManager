import 'package:taskmanager/model/task_model.dart';

class TaskList {
  List<TaskModel> taskList;

  static TaskList fromJson(Map<String, dynamic> json) {
    return TaskList()
      ..taskList = (json['taskList'] as List)
          ?.map((e) =>
              e == null ? null : TaskModel.fromJson(e as Map<String, dynamic>))
          ?.toList();
  }

  Map<String, dynamic> toJson(TaskList instance) =>
      <String, dynamic>{'taskList': instance.taskList};
}
