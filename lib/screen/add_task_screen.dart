import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/constants/colors_constants.dart';
import 'package:taskmanager/constants/variable_constants.dart';
import 'package:intl/date_symbol_data_local.dart' as sy;

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen>
    with TickerProviderStateMixin {
  GlobalKey<DayButtonItemState> leftKey;
  GlobalKey<DayButtonItemState> rightKey;
  GlobalKey<DayButtonItemState> middleKey;

  TextEditingController headerController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    leftKey = GlobalKey<DayButtonItemState>();
    rightKey = GlobalKey<DayButtonItemState>();
    middleKey = GlobalKey<DayButtonItemState>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
  int activeIndex = 0;
  String time = "09:00";

  @override
  Widget build(BuildContext context) {
    AppBar _appBar() {
      return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Add New Task",
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
                                            MediaQuery.of(context)
                                                .alwaysUse24HourFormat;
                                        return Container(
                                            height: MediaQuery.of(context)
                                                    .copyWith()
                                                    .size
                                                    .height /
                                                3,
                                            child: CupertinoDatePicker(
                                              initialDateTime: DateTime.now(),
                                              onDateTimeChanged:
                                                  (DateTime dateTime) {
                                                time = formatTimeOfDay(
                                                    TimeOfDay(
                                                        hour: dateTime.hour,
                                                        minute:
                                                            dateTime.minute));
                                              },
                                              use24hFormat: is12HoursFormat,
                                              minuteInterval: 1,
                                              mode:
                                                  CupertinoDatePickerMode.time,
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
                    ),
                    Column(
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
                    ),
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
              : () {},
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
            child: const Text('+ Add Task', style: TextStyle(fontSize: 20)),
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
}

class DayButtonItem extends StatefulWidget {
  @override
  DayButtonItemState createState() => DayButtonItemState(
        this.callback,
      );

  final int index;

  bool isSelect = false;

  final String buttonName;

  final GlobalKey<DayButtonItemState> key;

  void Function(int) callback;

  DayButtonItem(
      {@required this.key,
      @required this.callback,
      @required this.index,
      @required this.buttonName,
      @required this.isSelect});
}

class DayButtonItemState extends State<DayButtonItem> {
  void Function(int) callback;

  DayButtonItemState(this.callback);

  updateSelect(bool select) {
    setState(() {
      widget.isSelect = select;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback(widget.index);
      },
      child: Container(
        height: ScreenUtil().setHeight(85),
        width: ScreenUtil().setWidth(250),
        decoration: BoxDecoration(
            border: widget.isSelect
                ? Border.all(color: Colors.green, width: 3)
                : Border.all(color: Colors.black),
            gradient: widget.isSelect
                ? LinearGradient(
                    colors: [HexColor("FF9100"), HexColor("FF4081")],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(10.0)),
        alignment: AlignmentDirectional.center,
        child: Text(
          widget.buttonName,
          style: TextStyle(
              color: widget.isSelect ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstants.fontFamily,
              fontSize: ScreenUtil().setSp(38)),
        ),
      ),
    );
  }
}
