import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/bloc/data/bloc.dart';
import 'package:taskmanager/route/app_route.dart';

void main() {
  runApp(BlocProvider<DataBlocBloc>(
    create: (context) =>
        DataBlocBloc(InitialDataBlocState())..add(GetTaskList()),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.initialRoute,
      routes: AppRoute.routes,
    ),
  ));
}
