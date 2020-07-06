import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/bloc/data/bloc.dart';
import 'package:taskmanager/calendar/table_calendar.dart';
import 'package:taskmanager/constants/colors_constants.dart';
import 'package:taskmanager/constants/variable_constants.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay;

  Map<DateTime, List<DateTime>> _events;

  CalendarController _calendarController;

  List<DateTime> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = DateTime.now();

    list = List<DateTime>();
    _events = {};

    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(
              width: ScreenUtil().setHeight(1),
              color: Colors.grey.shade300,
            ),
            bottom: BorderSide(
              width: ScreenUtil().setHeight(1),
              color: Colors.grey.shade300,
            )),
      ),
      child: BlocListener<DataBlocBloc, DataBlocState>(
        listener: (context, state) {
          if (state is DataLoadedState) {
            if (state.taskList != null && state.taskList.length > 0) {
              if (list != null) list.clear();
              state.taskList.forEach((element) {
                DateTime dateTime = DateTime.parse(element.dateTime);
                list.add(dateTime);
                print(dateTime.toString());
              });
              _events[DateTime(2010, 11, 11)] = list;
              setState(() {
                list.forEach((a) {
                  _events[a] = list;
                });
              });

            }
          }
        },
        child: TableCalendar(
          availableCalendarFormats: {
            CalendarFormat.month: Icon(
              Icons.keyboard_arrow_down,
              size: 27,
              color: Colors.black,
            ),
            CalendarFormat.week: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.black,
              size: 27,
            ),
          },
          availableGestures: AvailableGestures.horizontalSwipe,
          calendarController: _calendarController,
          events: _events,
          rowHeight: ScreenUtil().setHeight(150),
          onHeaderTapped: (date) {
            _calendarController.setSelectedDay(DateTime.now());
            _onDaySelected(DateTime.now(), list);
          },
          selectedDate: _selectedDay,
          initialCalendarFormat: CalendarFormat.week,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          calendarStyle: CalendarStyle(
            markersColor: isToday() ? Colors.red : AppColor.calendarHeader,
            markersPositionBottom: ScreenUtil().setHeight(40),
            todayStyle: TextStyle(
                color: Colors.black,
                fontFamily: AppConstants.fontFamily,
                fontSize: ScreenUtil().setSp(42)),
            outsideHolidayStyle:
            TextStyle().copyWith(color: Colors.black, fontSize: 16),
            outsideWeekendStyle:
            TextStyle().copyWith(color: Colors.black, fontSize: 16),
            outsideStyle: TextStyle().copyWith(
                color: Colors.black,
                fontFamily: AppConstants.fontFamily,
                fontSize: ScreenUtil().setSp(42)),
            holidayStyle: TextStyle().copyWith(
                color: Colors.black,
                fontFamily: AppConstants.fontFamily,
                fontSize: ScreenUtil().setSp(42)),
            weekendStyle: TextStyle().copyWith(
                color: Colors.black,
                fontFamily: AppConstants.fontFamily,
                fontSize: ScreenUtil().setSp(42)),
            weekdayStyle: TextStyle().copyWith(
                color: Colors.black,
                fontFamily: AppConstants.fontFamily,
                fontSize: ScreenUtil().setSp(42)),
            selectedStyle: TextStyle().copyWith(
                color: Colors.white,
                fontFamily: AppConstants.fontFamily,
                fontSize: ScreenUtil().setSp(42)),
            markersMaxAmount: 1,
            selectedColor: isToday() ? Colors.red : Colors.blue,
            todayColor: Colors.transparent,
            outsideDaysVisible: true,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle().copyWith(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(42),
                fontFamily: AppConstants.fontFamily),
            weekendStyle: TextStyle().copyWith(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(42),
                fontFamily: AppConstants.fontFamily),
          ),
          formatAnimation: FormatAnimation.slide,
          headerStyle: HeaderStyle(
              formatButtonPadding:
              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              formatButtonDecoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(12.0))),
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.black,
              ),
              leftChevronIcon: Icon(
                Icons.arrow_back_ios,
                size: 15,
                color: Colors.black,
              ),
              centerHeaderTitle: true,
              formatButtonVisible: true,
              formatButtonTextStyle: TextStyle(
                fontSize: ScreenUtil().setSp(40),
                fontFamily: AppConstants.fontFamily,
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                  fontFamily: AppConstants.fontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(56))),
          onDaySelected: _onDaySelected,
          onVisibleDaysChanged: _onVisibleDaysChanged,
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List<Object> events) {
    _selectedDay = day;

    setState(() {});
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {}

  bool isToday() {
    return (_selectedDay.day - DateTime.now().day == 0 &&
        _selectedDay.year - DateTime.now().year == 0 &&
        _selectedDay.month - DateTime.now().month == 0);
  }
}
