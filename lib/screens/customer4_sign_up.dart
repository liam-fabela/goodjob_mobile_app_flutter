import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import '../styles/style.dart';
import 'customer5_sign_up.dart';
import '../widget/customer_input2.dart';

class Customer4SignUpScreen extends StatefulWidget {
  static const routeName = '/customer4_signup';
  @override
  _Customer4SignUpScreenState createState() => _Customer4SignUpScreenState();
}

class _Customer4SignUpScreenState extends State<Customer4SignUpScreen> {
   File _pickedImage1;
 File _pickedImage2;
 String file1;
 String file2;
 String base64Front;
 String base64Back;
  String lname;
  String fname;
  String bdate;
  String zone;
  String barangay;
  String base64Portrait;
  String filePhoto;

   @override
  void didChangeDependencies() {
    final ws3 = ModalRoute.of(context).settings.arguments as Map<String, String>;
    lname = ws3['lname'];
    fname = ws3['fname'];
    bdate = ws3['bdate'];
    zone = ws3['zone'];
    barangay = ws3['barangay'];
    filePhoto = ws3['filePhoto'];
    base64Portrait = ws3['base64Portrait'];
    super.didChangeDependencies();
  }

  void _selectImage1(File firstPickedImage, String fileName1) {

    _pickedImage1 = firstPickedImage;
     file1 = fileName1;
     base64Front = base64Encode(_pickedImage1.readAsBytesSync());
    
  }

  void _selectImage2(File secondPickedImage, String fileName2) {
    _pickedImage2 = secondPickedImage;
    file2 = fileName2;
    base64Back = base64Encode(_pickedImage2.readAsBytesSync());
  }

   void workerSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(
      Customer5SignUpScreen.routeName,
      arguments: {
        'lname' : lname,
        'fname' : fname,
        'bdate' : bdate,
        'zone'  : zone,
        'barangay': barangay,
        'filePhoto': filePhoto,
        'base64Portrait': base64Portrait,
        'file1' : file1,
        'base64Front' : base64Front,
        'file2' : file2,
        'base64Back': base64Back,
      }
    );
    print('MAO NI ANG WALA: $filePhoto');
    print(file1);
    print(file2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: appBarSign(context, 'Customer ID Requirement'),
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
              CustomerImageInput2(_selectImage1, _selectImage2),
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