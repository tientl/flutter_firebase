import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/service/auth.dart';
import 'app/landingPage.dart';
import 'app/sign_in/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Probuoi8());

}

class Probuoi8 extends StatelessWidget {
  const Probuoi8({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LandingPage(auth: Auth()));

  }
  }



