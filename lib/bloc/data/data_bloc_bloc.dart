import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:taskmanager/helper/database_helper.dart';
import 'package:taskmanager/model/task_model.dart';
import './bloc.dart';

class DataBlocBloc extends Bloc<DataBlocEvent, DataBlocState> {
  DataBlocBloc(DataBlocState initialState) : super(initialState);

  @override
  DataBlocState get initialState => InitialDataBlocState();

  @override
  Stream<DataBlocState> mapEventToState(
    DataBlocEvent event,
  ) async* {
    final currentState = state;

    if (event is GetTaskList) {
      List<TaskModel> taskList = await getTaskList();

      yield DataLoadedState(taskList: taskList);
    } else if (event is AddTaskEvent) {
      List<TaskModel> taskModel = List<TaskModel>();
      if (currentState is DataLoadedState && currentState.taskList != null)
        taskModel = currentState.taskList;
      taskModel.add(event.taskModel);
      bool isSuccess = await saveTaskModel(taskModel);
      print(isSuccess.toString());
    } else if (event is UpdateTaskEvent) {
      List<TaskModel> taskModel = List<TaskModel>();
      if (currentState is DataLoadedState) {
        taskModel = currentState.taskList;

        TaskModel updateModel = taskModel.firstWhere(
            (element) => element.uuid == event.taskModel.uuid,
            orElse: () => null);

        if (updateModel != null) {
          taskModel.remove(updateModel);
          taskModel.add(event.taskModel);
          taskModel.forEach((element) {
            print(element.header);
          });
          await saveTaskModel(taskModel);
        }
      }
    } else if (event is RemoveTaskEvent) {
      List<TaskModel> taskModel = List<TaskModel>();
      if (currentState is DataLoadedState) {
        taskModel = currentState.taskList;

        TaskModel updateModel = taskModel.firstWhere(
            (element) => element.uuid == event.uuid,
            orElse: () => null);

        if (updateModel != null) {
          taskModel.remove(updateModel);
          await saveTaskModel(taskModel);
        }
      }
    }
  }

  Future<List<TaskModel>> getTaskList() async {
    List<TaskModel> taskList = List<TaskModel>();

    try {
      taskList = await DataBaseHelper().getTaskList();
    } catch (e) {
      print(e);
      taskList = List<TaskModel>();
    }

    return taskList;
  }

  Future<bool> saveTaskModel(List<TaskModel> taskModel) async {
    try {
      bool isSuccess = await DataBaseHelper().saveTask(taskModel: taskModel);
      return isSuccess;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
