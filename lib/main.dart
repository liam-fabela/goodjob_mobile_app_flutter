import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './helper/authenticate.dart';


import './screens/worker_sign_up.dart';
import './screens/worker2_sign_up.dart';
import './screens/worker3_sign_up.dart';
import './screens/worker4_sign_up.dart';
import './screens/worker5_sign_up.dart';
import './screens/worker6_sign_up.dart';
import './screens/worker7_sign_up.dart';
import './screens/worker_OTP_screen.dart';
import './screens/worker_home_screen.dart';
import './screens/customer_sign_up.dart';
import './screens/customer2_sign_up.dart';
//import './screens/customer3_sign_up.dart';
//import './screens/customer4_sign_up.dart';
import './screens/customer5_sign_up.dart';
import './screens/customer_otp.dart';
import './providers/worker.dart';
import './screens/customer_home_screen.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: WorkerProvider(),
          )
        ],
        child: MaterialApp(
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
          WorkerOTPScreen.routeName: (ctx) => WorkerOTPScreen(),
          CustomerSignUpScreen.routeName: (ctx) => CustomerSignUpScreen(),
          Customer2SignUpScreen.routeName: (ctx) => Customer2SignUpScreen(),
         // Customer3SignUpScreen.routeName: (ctx) => Customer3SignUpScreen(),
         //Customer4SignUpScreen.routeName: (ctx) => Customer4SignUpScreen(),
          Customer5SignUpScreen.routeName: (ctx) => Customer5SignUpScreen(),
          CustomerOTP.routeName: (ctx) => CustomerOTP(),
      
        }
      ),
    );
  }
}

