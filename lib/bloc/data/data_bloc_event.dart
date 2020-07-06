import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskmanager/model/task_model.dart';

abstract class DataBlocEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [props];

  const DataBlocEvent();
}

class AddTaskEvent extends DataBlocEvent {
  final TaskModel taskModel;

  const AddTaskEvent({@required this.taskModel});

  @override
  // TODO: implement props
  List<Object> get props => [taskModel];
}
class UpdateTaskEvent extends DataBlocEvent {
  final TaskModel taskModel;

  const UpdateTaskEvent({@required this.taskModel});

  @override
  // TODO: implement props
  List<Object> get props => [taskModel];
}

class RemoveTaskEvent extends DataBlocEvent {
  final String uuid;

  const RemoveTaskEvent({@required this.uuid});

  @override
  // TODO: implement props
  List<Object> get props => [uuid];
}

class GetTaskList extends DataBlocEvent {

  const GetTaskList();

  @override
  // TODO: implement props
  List<Object> get props => super.props;

}
