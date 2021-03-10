import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

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
   String fileDoc;
   String base64Doc;
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
   int sel;
   String radioValue;

   @override
  void didChangeDependencies() {
    final ws4 = ModalRoute.of(context).settings.arguments as Map<String, String>;
    lname = ws4['lname'];
    fname = ws4['fname'];
    bdate = ws4['bdate'];
    zone = ws4['zone'];
    barangay = ws4['barangay'];
    base64Portrait = ws4['base64Portrait'];
    filePhoto = ws4['filePhoto'];
    base64Front = ws4['base64Front'];
    base64Back = ws4['base64Back'];
    file1 = ws4['file1'];
    file2 = ws4['file2'];
    super.didChangeDependencies();
  }

    void _selectImage(File pickedImage,String fileName ) {
    _pickedImage = pickedImage;
    fileDoc = fileName;
    base64Doc = base64Encode(_pickedImage.readAsBytesSync());
  }

  void _selectedRadio(int selected) {
    sel= selected;
    radioValue = sel.toString();

  }

    void workerSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(
      Worker7SignUp.routeName,
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
        'radioValue' : radioValue,
        'fileDoc' : fileDoc,
        'base64Doc': base64Doc,
      }
    );
    print('MAO NI ANG WALA: $filePhoto');
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
                              ImageInput3(_selectImage, _selectedRadio),
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
