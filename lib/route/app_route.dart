
import 'package:flutter/material.dart';
import 'package:taskmanager/screen/add_task_screen.dart';
import 'package:taskmanager/screen/home_screen.dart';

class AppRoute {
  static String initialRoute = "/";
  static final String home = "/";
  static final String addTask = "/addTask";
  static final Map<String, WidgetBuilder> routes = {
    home: (context) => HomeScreen(),
    addTask:(context) => AddTaskScreen(),
  };
}