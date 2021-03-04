import 'package:flutter/material.dart';
import 'dart:io';

import '../styles/style.dart';
import '../widget/image_input2.dart';
import '../screens/worker6_sign_up.dart';




class Worker5SignUp extends StatelessWidget {

 static const routeName = '/worker5-signup';
  

  void _selectImage(File firstPickedImage, File secondPickedImage) {

   
    
  File _pickedImage1;
  File _pickedImage2;
    _pickedImage1 = firstPickedImage;
     _pickedImage2 = secondPickedImage;
  }

   void workerSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(
      Worker6SignUp.routeName
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
                      child: Column( children: <Widget>[
                     Text(
                    'Attach Valid ID Photos',
                     style: TextStyle(
                    color: Colors.black54, fontSize: 16, fontFamily: 'Raleway'),
                    textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ImageInput2(_selectImage),
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
