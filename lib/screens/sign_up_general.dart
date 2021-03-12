import 'package:flutter/material.dart';


import '../styles/style.dart';
import 'customer_sign_up.dart';
import 'worker_sign_up.dart';

class SignUpGeneral extends StatefulWidget {
  final Function toggle;

  SignUpGeneral(this.toggle);
  @override
  _SignUpGeneralState createState() => _SignUpGeneralState();
}

class _SignUpGeneralState extends State<SignUpGeneral> {

  void customerSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(
      CustomerSignUpScreen.routeName
    );

  }

  void workerSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(
      WorkerSignUp.routeName
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            signUpCategory(context, 'Sign up as Customer', 'assets/images/good_job.png', ()=>customerSignUp(context)),
            SizedBox(height: 12),
            signUpCategory(context, 'Sign up as Worker', 'assets/images/worker3.jpg', ()=>workerSignUp(context)),
            SizedBox(height: 16),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('Already have an account? ', style:  mediumTextStyle(),),
                GestureDetector(
                  onTap: () {
                    widget.toggle();
                  },
                    child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Login now', style:  TextStyle(
                          color: Colors.white, 
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                    ),),
                  ),
                ),
              ],),
      ],),
    );
  }
}
