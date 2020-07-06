import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/bloc/data/bloc.dart';
import 'package:taskmanager/constants/colors_constants.dart';
import 'package:taskmanager/constants/variable_constants.dart';
import 'package:taskmanager/route/app_route.dart';

class ListTaskScreen extends StatefulWidget {
  @override
  _ListTaskScreenState createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<DataBlocBloc, DataBlocState>(
      builder: (context, state) {
        if (state is DataLoadedState) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.taskList.length,
              itemBuilder: (context, index) {
                DateTime dateTime =
                    DateTime.parse(state.taskList[index].dateTime);
                bool isDone = state.taskList[index].isDone;

                bool isToday = isTodayMethod(dateTime);

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: state.taskList.length - 1 == index
                          ? ScreenUtil().setHeight(50)
                          : 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.addTask,
                          arguments: state.taskList[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setHeight(50),
                        top: ScreenUtil().setHeight(20),
                        right: ScreenUtil().setHeight(50),
                      ),
                      height: ScreenUtil().setHeight(450),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height:
                                      ScreenUtil().setHeight(isToday ? 50 : 30),
                                  width:
                                      ScreenUtil().setHeight(isToday ? 50 : 30),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          isDone ? Colors.green : Colors.orange,
                                    ),
                                  ),
                                  alignment: AlignmentDirectional.center,
                                  child: isToday
                                      ? Container(
                                          height: ScreenUtil().setHeight(30),
                                          width: ScreenUtil().setHeight(30),
                                          decoration: BoxDecoration(
                                              color: isDone
                                                  ? Colors.green
                                                  : Colors.orange,
                                              shape: BoxShape.circle),
                                        )
                                      : Container(),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                Expanded(
                                  child: Container(
                                    width: ScreenUtil().setWidth(10),
                                    color:
                                        isDone ? Colors.green : Colors.orange,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(50),
                                  horizontal: ScreenUtil().setWidth(50)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: isDone
                                      ? Colors.green
                                      : HexColor("f0a500").withOpacity(0.9)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        state.taskList[index].header,
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(52),
                                          fontFamily: AppConstants.fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            DateFormat.Hm().format(dateTime),
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(42),
                                              fontFamily:
                                                  AppConstants.fontFamily,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            DateFormat.MMMMd().format(dateTime),
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(42),
                                              fontFamily:
                                                  AppConstants.fontFamily,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    state.taskList[index].content,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(52),
                                      fontFamily: AppConstants.fontFamily,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.asset(
                                                    AppConstants
                                                        .bilalProfileImage,
                                                    fit: BoxFit.cover))),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          state.taskList[index].isDone =
                                              !state.taskList[index].isDone;
                                          setState(() {});
                                        },
                                        child: state.taskList[index].isDone
                                            ? Icon(Icons.check)
                                            : Icon(
                                                Icons.radio_button_unchecked),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }

        return Container();
      },
    );
  }

  bool isTodayMethod(DateTime dateTime) {
    return (dateTime.day - DateTime.now().day == 0 &&
        dateTime.year - DateTime.now().year == 0 &&
        dateTime.month - DateTime.now().month == 0);
  }
}
