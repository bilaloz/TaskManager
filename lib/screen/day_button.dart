

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:taskmanager/constants/colors_constants.dart';
import 'package:taskmanager/constants/variable_constants.dart';

class DayButtonItem extends StatefulWidget {
  @override
  DayButtonItemState createState() =>
      DayButtonItemState(
        this.callback,
      );

  final int index;

  bool isSelect = false;

  final String buttonName;

  final GlobalKey<DayButtonItemState> key;

  void Function(int) callback;

  DayButtonItem({@required this.key,
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