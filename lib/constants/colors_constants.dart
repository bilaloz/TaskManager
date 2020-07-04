import 'package:flutter/material.dart';

class AppColor {
  static final Color darkGreen = HexColor("#009C86");
  static final Color darkerBlue = HexColor("#00809C");
  static final Color appBarBg = HexColor("#E8EFF5");
  static final Color cardBg = HexColor("#F6F6F6");
  static final Color tabBarColor = Color.fromRGBO(249, 252, 255, 0.95);
  static final Color darkGrey = HexColor("#D5E3F1");
  static final Color newBorderColor = HexColor("#D5E3F1");
  static final Color calendarHeader = HexColor("#93ABC3");
  static final Color disableColor = HexColor("#E3E3E3");
  static final Color calendarWeakDayColor = HexColor("#BBBBBB");
  static final Color black = HexColor("#333333");
  static final Color bgColor = HexColor("#F9FCFF");
  static final Color slideItemRed = HexColor("#F87D76");
  static final Color slideItemOrange = HexColor("#F8BC76");
  static final Color addEventTextColor = HexColor("#B7CADD");
  static final Color activeAddPlantBorder = HexColor("#F0F6FC");
  static final Color cameraIconColor = HexColor("D9E7F3");
  static final Color containerColor = HexColor("#D5E3F1");
  static final Color dissableColor = HexColor("#D9D9D9");
  static final Color cursorColor = HexColor("#CCDCEB");
  static final Color blackColor = HexColor("#333333");
  static final Color disableButtonColor = HexColor("#C7E9E4");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
