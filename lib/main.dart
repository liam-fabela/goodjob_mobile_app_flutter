import 'package:flutter/material.dart';


import './helper/authenticate.dart';


import './screens/worker_sign_up.dart';
import './screens/worker2_sign_up.dart';
import './screens/worker3_sign_up.dart';
import './screens/worker4_sign_up.dart';
import './screens/worker5_sign_up.dart';
import './screens/worker6_sign_up.dart';
import './screens/worker7_sign_up.dart';
import './screens/worker_home_screen.dart';






void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Good Job!',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.white10,
        canvasColor: Color.fromRGBO(75, 210, 178, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
              button: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
      ),
      ),
      initialRoute: '/',
      routes: {
        '/' : (ctx) => Authenticate(),
        WorkerHomeScreen.routeName : (ctx) => WorkerHomeScreen(),
        WorkerSignUp.routeName : (ctx) => WorkerSignUp(),
        Worker2SignUp.routeName : (ctx) => Worker2SignUp(),
        Worker3SignUp.routeName : (ctx) => Worker3SignUp(),
        Worker4SignUp.routeName : (ctx) => Worker4SignUp(),
        Worker5SignUp.routeName : (ctx) => Worker5SignUp(),
        Worker6SignUp.routeName : (ctx) => Worker6SignUp(),
        Worker7SignUp.routeName : (ctx) => Worker7SignUp(),
      }
    );
  }
}

