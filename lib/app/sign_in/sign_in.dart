import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/CutomizeControl/CustomizeElevatedButton.dart';
import 'package:untitled/app/service/auth_base.dart';
import 'package:untitled/app/sign_in/Email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key,required this.onSignIn, required this.auth}) : super(key:key);
  final void Function(User) onSignIn;
  final AuthBase auth;

  void _SignInWithEmail(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>EmailSignInPage()));
  }


  Future<User?> _SignInGoogle() async{
    try{
      User? user = await auth.SignInGoogle();
    }
    catch(e)
    {
      print(e.toString());
    };
  }

  Future<UserCredential?> _SignInFB() async{
    try{
      UserCredential userCredential = await auth.signInWithFacebook();
    }
    catch(e)
    {
      print(e.toString());
    };
  }
  Future<void> _SignInAnonymously() async {
    try{
      // UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      // onSignIn(userCredential.user!);
      User? user = await auth.SignInAnonymously();
      onSignIn(user!);
    }
    catch(e){
      print(e.toString());
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Practical lesson one"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        color: Colors.grey.shade100,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Sign in",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                //color: Colors.orange,
              ),
            ),
            SizedBox(height: 10),
            CustomizeElevatedButton(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('images/google-logo.png'),
                  Text(
                    'Sign in with Google',
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Opacity(child: Image.asset('images/facebook-logo.png'), opacity: 0),
                ],
              ),
              backgroundColor: Colors.white,
              onPressed: (){
                _SignInGoogle();
              },
            ),
            SizedBox(height: 10,),
            CustomizeElevatedButton(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('images/facebook-logo.png'),
                  Text(
                    'Sign in with Facebook',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Opacity(child: Image.asset('images/facebook-logo.png'), opacity: 0),
                ],
              ),
              backgroundColor: Colors.indigo,
              onPressed: () {
                _SignInFB();
              },
            ),
            SizedBox(height: 10,),
            CustomizeElevatedButton(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('images/email-logo.png'),
                  Text(
                    'Sign in with Email',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Opacity(child: Image.asset('images/facebook-logo.png'), opacity: 0),
                ],
              ),
              backgroundColor: Colors.orange,
              onPressed: (){
                _SignInWithEmail(context);
              },
            ),
            SizedBox(height: 10,),
            Text(
                'Or',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                //color: Colors.orange,
              ),),
            SizedBox(height: 10,),
            CustomizeElevatedButton(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('images/anonymous-logo.png'),
                  Text(
                    'Sign in with Anoymous',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Opacity(child: Image.asset('images/facebook-logo.png'), opacity: 0),
                ],
              ),
              backgroundColor: Colors.greenAccent,
              onPressed: (){
                //HomePage(onSignOut: () {  }, auth:  ,);
                _SignInAnonymously();
              },
            ),
            SizedBox(height: 10,),



          ],
        ),
      ),
    ));
  }


}
