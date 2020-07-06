import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/bloc/data/bloc.dart';
import 'package:taskmanager/constants/colors_constants.dart';
import 'package:taskmanager/constants/variable_constants.dart';
import 'package:taskmanager/model/task_model.dart';
import 'package:taskmanager/screen/day_button.dart';
import 'package:taskmanager/screen/success_message.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen>
    with TickerProviderStateMixin {
  GlobalKey<DayButtonItemState> leftKey;
  GlobalKey<DayButtonItemState> rightKey;
  GlobalKey<DayButtonItemState> middleKey;

  TextEditingController headerController;
  TextEditingController contentController;

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenArguments = ModalRoute.of(context).settings.arguments;

      if (screenArguments != null) {
        contentController.text = screenArguments.content;
        headerController.text = screenArguments.header;

        DateTime dateTime = DateTime.parse(screenArguments.dateTime);
        selectedDate = dateTime;
        selectedTimeOfDay =
            TimeOfDay(hour: selectedDate.hour, minute: selectedDate.hour);
        header = "Update Task";
        addButtonText = "Update Now";
        time = formatTimeOfDay(selectedTimeOfDay);
        if (isTodayMethod(dateTime)) {
          activeIndex = 0;
        } else
          activeIndex = 2;
      }
      setState(() {

      });


    });

    super.initState();

    headerController = TextEditingController();
    contentController = TextEditingController();
    leftKey = GlobalKey<DayButtonItemState>();
    rightKey = GlobalKey<DayButtonItemState>();
    middleKey = GlobalKey<DayButtonItemState>();
    selectedDate = DateTime.now();
    selectedTimeOfDay =
        TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute);



  }

  TaskModel screenArguments;

  String header = "Add New Task";
  String addButtonText = "+ Add Task";

  bool isTodayMethod(DateTime dateTime) {
    return (dateTime.day - DateTime.now().day == 0 &&
        dateTime.year - DateTime.now().year == 0 &&
        dateTime.month - DateTime.now().month == 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
  int activeIndex = 0;
  String time = "09:00";
  DateTime selectedDate;

  TimeOfDay selectedTimeOfDay;

  @override
  Widget build(BuildContext context) {
    AppBar _appBar() {
      return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            screenArguments != null ? removeButtonWidget() : Container()
          ],
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: ScreenUtil().setHeight(80),
              color: Colors.black,
            ),
          ));
    }

    Widget getData() {
      return Container(
        height: ScreenUtil().setHeight(200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "When",
              style: TextStyle(
                  fontFamily: AppConstants.fontFamily,
                  fontSize: ScreenUtil().setSp(62),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DayButtonItem(
                    key: leftKey,
                    buttonName: "Today",
                    isSelect: activeIndex != 0 ? false : true,
                    index: 0,
                    callback: (index) {
                      selectedItem(index);
                      selectedDate = DateTime.now();
                      date = DateFormat.yMMMMEEEEd().format(DateTime.now());
                      setState(() {
                        activeIndex = 0;
                      });
                    }),
                DayButtonItem(
                    key: middleKey,
                    buttonName: "Tomorrow",
                    isSelect: activeIndex != 1 ? false : true,
                    index: 1,
                    callback: (index) {
                      selectedItem(index);
                      selectedDate = DateTime.now().add(Duration(days: 1));
                      date = DateFormat.yMMMMEEEEd()
                          .format(DateTime.now().add(Duration(days: 1)));
                      setState(() {
                        activeIndex = 1;
                      });
                    }),
                DayButtonItem(
                    key: rightKey,
                    index: 2,
                    isSelect: activeIndex != 2 ? false : true,
                    buttonName: "Other",
                    callback: (index) async {
                      selectedItem(index);
                      await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            bool is12HoursFormat =
                                MediaQuery.of(context).alwaysUse24HourFormat;
                            return Container(
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height /
                                    3,
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (DateTime dateTime) {
                                    selectedDate = dateTime;
                                    date = DateFormat.yMMMMEEEEd()
                                        .format(dateTime);
                                  },
                                  use24hFormat: is12HoursFormat,
                                  minuteInterval: 1,
                                  mode: CupertinoDatePickerMode.date,
                                ));
                          });

                      setState(() {
                        activeIndex = 2;
                      });
                    }),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: _appBar(),
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(150),
                    horizontal: ScreenUtil().setHeight(50)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    getHeader(),
                    getBody(),
                    getData(),
                    date != null
                        ? Text(
                            date,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(55),
                                fontFamily: AppConstants.fontFamily,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          )
                        : Container()
                  ],
                ),
              ),
              _addButton(),
            ],
          ),
        ),
      ),
    );
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();

    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);

    bool is12HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    DateFormat format; //"6:00 AM"

    if (!is12HoursFormat) {
      format = DateFormat.jm();
    } else {
      format = DateFormat.Hm();
    }
    return format.format(dt);
  }

  Widget _addButton() {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(150),
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(20),
            horizontal: ScreenUtil().setWidth(50)),
        child: RaisedButton(
          onPressed: contentController.text.length < 1 ||
                  headerController.text.length < 1
              ? null
              : () {
                  if (screenArguments == null) {
                    var uuid = Uuid();

                    selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTimeOfDay.hour,
                        selectedTimeOfDay.minute);

                    BlocProvider.of<DataBlocBloc>(context).add(AddTaskEvent(
                        taskModel: TaskModel(
                            header: headerController.text,
                            content: contentController.text,
                            dateTime: selectedDate.toString(),
                            uuid: uuid.v1(),
                            isDone: false)));
                  } else {
                    selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTimeOfDay.hour,
                        selectedTimeOfDay.minute);

                    BlocProvider.of<DataBlocBloc>(context).add(UpdateTaskEvent(
                        taskModel: TaskModel(
                            header: headerController.text,
                            content: contentController.text,
                            dateTime: selectedDate.toString(),
                            uuid: screenArguments.uuid,
                            isDone: screenArguments.isDone)));
                  }
                  BlocProvider.of<DataBlocBloc>(context).add(GetTaskList());
                  successMessage();
                },
          elevation: 2,
          color: Colors.red,
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          child: Container(
            alignment: AlignmentDirectional.center,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: contentController.text.length < 1 ||
                        headerController.text.length < 1
                    ? null
                    : LinearGradient(
                        colors: [HexColor("FF9100"), HexColor("FF4081")],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                borderRadius: BorderRadius.all(Radius.circular(80.0))),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(addButtonText, style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }

  void selectedItem(int index) {
    if (index == 0) {
      rightKey.currentState.updateSelect(false);
      leftKey.currentState.updateSelect(true);
      middleKey.currentState.updateSelect(false);
    } else if (index == 1) {
      rightKey.currentState.updateSelect(false);
      leftKey.currentState.updateSelect(false);
      middleKey.currentState.updateSelect(true);
    } else if (index == 2) {
      rightKey.currentState.updateSelect(true);
      leftKey.currentState.updateSelect(false);
      middleKey.currentState.updateSelect(false);
    }
  }

  Widget getHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              header,
              style: TextStyle(
                fontFamily: AppConstants.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(102),
              ),
            ),
            InkWell(
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        bool is12HoursFormat =
                            MediaQuery.of(context).alwaysUse24HourFormat;
                        return Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    3,
                            child: CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              onDateTimeChanged: (DateTime dateTime) {
                                selectedTimeOfDay = TimeOfDay(
                                    hour: dateTime.hour,
                                    minute: dateTime.minute);

                                time = formatTimeOfDay(selectedTimeOfDay);
                              },
                              use24hFormat: is12HoursFormat,
                              minuteInterval: 1,
                              mode: CupertinoDatePickerMode.time,
                            ));
                      });

                  setState(() {});
                },
                child: Lottie.asset(AppConstants.clockAnimation,
                    repeat: false, width: 60, height: 60)),
          ],
        ),
        Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontFamily: AppConstants.fontFamily,
            fontSize: ScreenUtil().setSp(56),
          ),
        )
      ],
    );
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
              hintText: "e.g. Recharge iphone",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(62),
                  fontFamily: AppConstants.fontFamily,
                  color: Colors.grey.shade400)),
          controller: headerController,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(62),
              fontWeight: FontWeight.w500,
              fontFamily: AppConstants.fontFamily,
              color: Colors.black),
        ),
        TextField(
          controller: contentController,
          onChanged: (value) {
            setState(() {});
          },
          style: TextStyle(
              fontSize: ScreenUtil().setSp(42),
              fontFamily: AppConstants.fontFamily,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
      ],
    );
  }

  Widget removeButtonWidget() {
    return InkWell(
        onTap: () {
          Widget cancelButton = FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                fontFamily: AppConstants.fontFamily,
                color: AppColor.darkGreen,
                fontSize: ScreenUtil().setSp(42),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
          Widget continueButton = FlatButton(
            child: Text(
              "Yes",
              style: TextStyle(
                fontFamily: AppConstants.fontFamily,
                color: AppColor.darkGreen,
                fontSize: ScreenUtil().setSp(42),
              ),
            ),
            onPressed: () {
              BlocProvider.of<DataBlocBloc>(context)
                  .add(RemoveTaskEvent(uuid: screenArguments.uuid));
              BlocProvider.of<DataBlocBloc>(context).add(GetTaskList());
              successMessage();
            },
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text(
              "Remove Dialog",
              style: TextStyle(
                fontFamily: AppConstants.fontFamily,
                color: Colors.black,
                fontSize: ScreenUtil().setSp(52),
              ),
            ),
            content: Text(
              "Are you sure ?",
              style: TextStyle(
                fontFamily: AppConstants.fontFamily,
                fontSize: ScreenUtil().setSp(42),
              ),
            ),
            actions: [
              cancelButton,
              continueButton,
            ],
          );

          showCupertinoDialog(
              context: context,
              builder: (context) {
                return alert;
              });
        },
        child: Container(
          margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
          child: Icon(
            Icons.restore_from_trash,
            color: Colors.black,
            size: 33,
          ),
        ));
  }

  successMessage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SuccessErrorOverlay(
                  isCorrect: true,
                  backgroundColor: Color.fromRGBO(59, 53, 96, 0.9),
                  onTap: () {},
                )));
  }
}
