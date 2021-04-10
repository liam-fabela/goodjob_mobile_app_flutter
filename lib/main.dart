import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';

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
import 'providers/data.dart';
import './screens/customer_home_screen.dart';
import './screens/worker_holding_screen.dart';
//import './screens/create_post.dart';
import './screens/worker_categories_screen.dart';
import './helper/shared_preferences.dart';
import './screens/worker_profile_details.dart';
import './screens/customer_reviews.dart';

var initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await SharedPrefUtils.getPref('user');
  print('FROM MAIN: $initScreen');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DataProvider(),
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
                    color: Colors.black54,
                  ),
                  button: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
          
          ),
          initialRoute: initScreen == null
              ? '/'
              : initScreen == 1
                  ? '/worker_home'
                  : '/customer_home',
          routes: {
            '/': (ctx) =>
                Authenticate(), //CustomerHomeScreen(),//Authenticate()WorkerCategoryScreen(),
            '/worker_home': (ctx) => WorkerHomeScreen(),
            WorkerSignUp.routeName: (ctx) => WorkerSignUp(),
            Worker2SignUp.routeName: (ctx) => Worker2SignUp(),
            Worker3SignUp.routeName: (ctx) => Worker3SignUp(),
            Worker4SignUp.routeName: (ctx) => Worker4SignUp(),
            Worker5SignUp.routeName: (ctx) => Worker5SignUp(),
            Worker6SignUp.routeName: (ctx) => Worker6SignUp(),
            Worker7SignUp.routeName: (ctx) => Worker7SignUp(),
            WorkerOTPScreen.routeName: (ctx) => WorkerOTPScreen(),
            CustomerSignUpScreen.routeName: (ctx) => CustomerSignUpScreen(),
            Customer2SignUpScreen.routeName: (ctx) => Customer2SignUpScreen(),
            // Customer3SignUpScreen.routeName: (ctx) => Customer3SignUpScreen(),
            //Customer4SignUpScreen.routeName: (ctx) => Customer4SignUpScreen(),
            Customer5SignUpScreen.routeName: (ctx) => Customer5SignUpScreen(),
            CustomerOTP.routeName: (ctx) => CustomerOTP(),
            '/customer_home': (ctx) => CustomerHomeScreen(),
           WorkerHoldingScreen.routeName: (ctx) => WorkerHoldingScreen(),
           // CreatePostModal.routeName: (ctx) => CreatePostModal(),
            WorkerCategoryScreen.routeName: (ctx) => WorkerCategoryScreen(),
            ProfileDetails.routeName: (ctx) => ProfileDetails(),
            CustomerReviewScreen.routeName: (ctx) => CustomerReviewScreen(),
          }),
    );
  }
}
