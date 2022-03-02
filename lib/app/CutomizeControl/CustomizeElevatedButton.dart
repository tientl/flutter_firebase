import 'package:flutter/material.dart';


class CustomizeElevatedButton extends StatelessWidget
{
  const CustomizeElevatedButton({
    required this.backgroundColor,
    this.boderRadius: 20,
    this.onPressed,
    this.textValue: '',
    this.textColor: Colors.black,
    this.textSize: 15,
    this.heightBox: 40,
    this.textFontWeight: FontWeight.bold,
    required this.widget,
    //required this.buttonHeigh,
});
  final Color backgroundColor;
  final double boderRadius;
  final VoidCallback? onPressed;
  final String textValue;
  final Color textColor;
  final double textSize;
  final FontWeight textFontWeight;
  final double heightBox;
  final Widget widget;
  //final int buttonHeigh,
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightBox,
      child: ElevatedButton(
        onPressed: onPressed,
        child: widget,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(boderRadius),
          ))
        ),
      )
    );


  }


}