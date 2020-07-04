import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/constants/colors_constants.dart';
import 'package:taskmanager/constants/variable_constants.dart';
import 'package:taskmanager/screen/calendar_screen.dart';
import 'package:taskmanager/screen/empty_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 1080, height: 1920, allowFontScaling: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              CalendarScreen(),
              EmptyTaskScreen(
                clickAddTask: () => Navigator.pushNamed(context, '/addTask'),
              )
            ],
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
