import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskmanager/constants/colors_constants.dart';
import 'package:taskmanager/constants/variable_constants.dart';
import 'package:taskmanager/screen/home_screen.dart';

class SuccessErrorOverlay extends StatefulWidget {
  final bool isCorrect;
  final VoidCallback onTap;
  final Color successColor;
  final Color backgroundColor;
  final Color errorColor;
  final String successText;
  final String ndSuccessText;
  final Color successTextColor;
  final String errorText;
  final String ndErrorText;
  final Color errorTextColor;

  SuccessErrorOverlay({@required this.isCorrect,
    @required this.onTap,
    this.backgroundColor = Colors.black54,
    this.successColor = Colors.green,
    this.errorColor = Colors.red,
    this.successText = "Success!",
    this.ndSuccessText = "",
    this.successTextColor = Colors.green,
    this.errorText = "Error Happened",
    this.ndErrorText = "",
    this.errorTextColor = Colors.red});

  @override
  State createState() => SuccessErrorOverlayState();
}

class SuccessErrorOverlayState extends State<SuccessErrorOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() =>
        this.setState(() {
          if (_iconAnimation.isCompleted) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        }));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.appBarBg,
      child: InkWell(
        onTap: () => widget.onTap(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration:
              BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
              child: Transform.rotate(
                angle: _iconAnimation.value * 2 * 3.14,
                child: Icon(
                  widget.isCorrect == true ? Icons.done : Icons.clear,
                  size: _iconAnimation.value * 50.0,
                  color: widget.isCorrect
                      ? AppColor.darkGreen
                      : widget.errorColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0), //rgb(57,181,74)
            ),
            Text(
              widget.isCorrect ? widget.successText : widget.errorText,
              style: TextStyle(
                color: widget.isCorrect
                    ? AppColor.darkGreen
                    : widget.errorTextColor,
                fontFamily: AppConstants.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(52),
              ),
            ),
            Text(
              widget.isCorrect ? widget.ndSuccessText : widget.ndErrorText,
              style: TextStyle(
                color: widget.isCorrect
                    ? widget.successTextColor
                    : widget.errorTextColor,
                fontSize: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
