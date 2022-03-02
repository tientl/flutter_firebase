//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/CutomizeControl/CustomizeElevatedButton.dart';

class FormSubmitButton extends CustomizeElevatedButton{
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
}) : super(
    backgroundColor: Colors.blue,
    boderRadius: 5,
    onPressed: onPressed,
    heightBox: 44,
    widget: Text(text,
    style: TextStyle(color: Colors.white, fontSize: 20
    ),
    )
  );
}