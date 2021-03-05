import 'package:flutter/material.dart';


import '../styles/style.dart';
import 'worker4_sign_up.dart';

class Worker3SignUp extends StatefulWidget {
  static const routeName = '/worker3_signup';
  @override
  _Worker3SignUpState createState() => _Worker3SignUpState();
}

class _Worker3SignUpState extends State<Worker3SignUp> {

  void workerSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(
      Worker4SignUp.routeName
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Worker Job Category'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              // width: MediaQuery.of(context).size.width * 0.2,
              child: Image.asset(
                'assets/images/good_job.png',
                fit: BoxFit.cover,
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(1, 101, 105, 1),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Color.fromRGBO(170, 225, 227, 1),
                  ),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Column(children: <Widget>[
                          Center(
                            child: Text('Choose a category/categories',
                            style: TextStyle(
                            color: Colors.black54, fontSize: 16, fontFamily: 'Raleway'),
                            ),
                          ),
                          
                          ],
                          ),
                        ),
                        //SizedBox(height: 30),
                        GestureDetector(
                              onTap: () => workerSignUp(context),
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(62, 135, 148, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Next',
                                  style: mediumTextStyle(),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
