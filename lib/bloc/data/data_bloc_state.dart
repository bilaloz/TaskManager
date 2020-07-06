import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskmanager/model/task_model.dart';

@immutable
abstract class DataBlocState extends Equatable {
  const DataBlocState();
}

class InitialDataBlocState extends DataBlocState {
  @override
  List<Object> get props => [];
}

class DataLoadedState extends DataBlocState {

  final List<TaskModel> taskList;

  const DataLoadedState({@required this.taskList});

  @override
  List<Object> get props => [taskList];
}

