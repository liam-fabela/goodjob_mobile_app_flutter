import 'package:flutter/material.dart';
import 'dart:io';

import '../styles/style.dart';
import 'worker7_sign_up.dart';
import '../widget/image_input3.dart';

class Worker6SignUp extends StatefulWidget {
  static const routeName = '/worker6_signup';

  @override
  _Worker6SignUpState createState() => _Worker6SignUpState();
}



class _Worker6SignUpState extends State<Worker6SignUp> {
   File _pickedImage;
  
    void _selectImage(File pickedImage) {
 

    _pickedImage = pickedImage;

  }

    void workerSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(
      Worker7SignUp.routeName
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Worker Requirements'),
      body: Column(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                         child: Column(
                           children: <Widget>[
                              Text(
                                'Attach Document Here',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontFamily: 'Raleway'),
                                textAlign: TextAlign.center,
                              ),
                              ImageInput3(_selectImage),
                           ],
                         ),
                    ),
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
            ],
          ),
        ],
      ),
    );
  }
}
