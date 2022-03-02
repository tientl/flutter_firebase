//@dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app/home_page.dart';
import 'package:untitled/app/service/auth.dart';
import 'package:untitled/app/service/auth_base.dart';
import 'package:untitled/app/service/database.dart';
import 'package:untitled/app/sign_in/sign_in.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key, this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> SignInAnonymously() async{
    try{
      await auth.SignInAnonymously();
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context){
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapShot){
        if(snapShot.connectionState ==ConnectionState.active){
          final User user = snapShot.data;
          if(user == null){
            return SignInPage( auth: auth);
          }
          return Provider<Database>(
              create: (_)=> FirestoreDatabase(uid: user.uid),
              child: HomePage( auth: auth));
        }
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            )
          ),
        );
      }
    );
  }


}

