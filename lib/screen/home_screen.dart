import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/bloc/data/bloc.dart';
import 'package:taskmanager/constants/colors_constants.dart';
import 'package:taskmanager/constants/variable_constants.dart';
import 'package:taskmanager/screen/calendar_screen.dart';
import 'package:taskmanager/screen/empty_task_screen.dart';
import 'package:taskmanager/screen/list_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 1080, height: 1920, allowFontScaling: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: BlocBuilder<DataBlocBloc, DataBlocState>(
            builder: (context, state) {
              Widget activeWidget = EmptyTaskScreen(
                clickAddTask: () => Navigator.pushNamed(context, '/addTask'),
              );

              if (state is DataLoadedState) {
                if (state.taskList != null && state.taskList.length > 0) {
                  print(state.taskList.length.toString());
                  activeWidget = ListTaskScreen();
                }
              }

              return Column(
                children: <Widget>[
                  CalendarScreen(),
                  Expanded(child: activeWidget)
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addTask'),
        elevation: 2,
        backgroundColor: Colors.white,
        child: Lottie.asset(AppConstants.floatButtonAnimation, repeat: true),
      ),
    );
  }
}
