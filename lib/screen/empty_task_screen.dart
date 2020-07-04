import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/constants/variable_constants.dart';

class EmptyTaskScreen extends StatelessWidget {
  final VoidCallback clickAddTask;

  const EmptyTaskScreen({@required this.clickAddTask});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clickAddTask,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(100)),
        child: Column(
          children: <Widget>[
            Lottie.asset(AppConstants.emptyTaskAnimation, repeat: true),
            SizedBox(
              height: ScreenUtil().setHeight(60),
            ),
            Text(
              AppConstants.addTaskText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: AppConstants.fontFamily,
                  fontSize: ScreenUtil().setSp(42),
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
