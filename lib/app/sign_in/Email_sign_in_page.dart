import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/service/auth.dart';
import 'package:untitled/app/service/auth_base.dart';
import 'package:untitled/app/sign_in/Email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in Email'),
        elevation: 2.0,
      ),
      body:Card(child:EmailSignInForm(auth:Auth())),
      backgroundColor: Colors.white70,
    );
  }


}