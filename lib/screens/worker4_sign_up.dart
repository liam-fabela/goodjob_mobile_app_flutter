import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';

import '../styles/style.dart';
import '../widget/image_input.dart';
import 'worker5_sign_up.dart';



class Worker4SignUp extends StatefulWidget {

  static const routeName = '/worker4_signup';

  @override
  _Worker4SignUpState createState() => _Worker4SignUpState();
}

class _Worker4SignUpState extends State<Worker4SignUp> {
  String lname;
  String fname;
  String bdate;
  String zone;
  String barangay;
  String filePhoto;
  File _pickedImage;
  String base64Portrait;


  @override
  void didChangeDependencies() {
    final ws2 = ModalRoute.of(context).settings.arguments as Map<String, String>;
    lname = ws2['lname'];
    fname = ws2['fname'];
    bdate = ws2['bdate'];
    zone = ws2['zone'];
    barangay = ws2['barangay'];
    super.didChangeDependencies();
  }

  void selectImage(File pickedImage, String fileName) {
     
    filePhoto = fileName;
    _pickedImage = pickedImage;
    base64Portrait = base64Encode(_pickedImage.readAsBytesSync());


  }

  void workerSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(
      Worker5SignUp.routeName,
       arguments: {
        'lname': lname,
        'fname': fname,
        'bdate': bdate,
        'zone': zone,
        'barangay': barangay,
        'filePhoto': filePhoto,
        'base64Portrait': base64Portrait,
      }
    );
    print('PORTRAIT: $filePhoto');
    //print('MAO NI: $base64Image');
    // print(addr);
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
                      child: Column(children: <Widget>[
                      Text(
                      'Attach a Photo of Yourself',
                       style: TextStyle(
                      color: Colors.black54, fontSize: 16, fontFamily: 'Raleway'),
                      textAlign: TextAlign.center,
                     ),
                    
                    SizedBox(height: 20),
                     ImageInput1(selectImage),
                      ],
                      ),
                    ),
                   // SizedBox(height: 20),
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
