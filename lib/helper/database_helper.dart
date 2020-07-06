import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/model/task_list.dart';
import 'package:taskmanager/model/task_model.dart';

abstract class BaseMethod {
  Future<bool> saveTask({@required List<TaskModel> taskModel});

  Future<List<TaskModel>> getTaskList();
}

enum SaveType { TASK_LIST }

class DataBaseHelper implements BaseMethod {
  // Singleton properties
  static final DataBaseHelper _dataBaseHelper = DataBaseHelper._internal();

  factory DataBaseHelper() {
    return _dataBaseHelper;
  }

  DataBaseHelper._internal();

  @override
  Future<List<TaskModel>> getTaskList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var stringKey = SaveType.TASK_LIST.toString();

    try {
      Map remoteMap = jsonDecode(preferences.getString(stringKey));


      TaskList taskList = TaskList.fromJson(remoteMap);

      return taskList.taskList;
    } catch (e) {
      //throw UnimplementedError();
      return List<TaskModel>();
    }
  }

  @override
  Future<bool> saveTask({List<TaskModel> taskModel}) async {
    SharedPreferences save = await SharedPreferences.getInstance();

    var stringKey = SaveType.TASK_LIST.toString();

    TaskList taskList = TaskList();
    taskList.taskList = taskModel;

    try {
      String saveString = jsonEncode(taskList.toJson(taskList));
      bool isSuccess = await save.setString(stringKey, saveString);
      return isSuccess;
    } catch (e) {
      //throw UnimplementedError();
      return false;
    }
  }
}
