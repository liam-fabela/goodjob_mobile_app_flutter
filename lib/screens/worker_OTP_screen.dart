import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

import '../styles/style.dart';
import '../services/services.dart';
import 'worker_home_screen.dart';
import 'worker_holding_screen.dart';

class WorkerOTPScreen extends StatefulWidget {
  static const routeName = '/worker_otp';

  @override
  _WorkerOTPScreenState createState() => _WorkerOTPScreenState();
}

class _WorkerOTPScreenState extends State<WorkerOTPScreen> {
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
  String radioValue;
  int docID;
  String user;
  String email;
  String pass;
  TextEditingController _otp = TextEditingController();
  var _isLoading = false;

 
  @override
  void didChangeDependencies() {
    final ws6 =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    lname = ws6['lname'];
    fname = ws6['fname'];
    bdate = ws6['bdate'];
    zone = ws6['zone'];
    barangay = ws6['barangay'];
    base64Portrait = ws6['base64Portrait'];
    filePhoto = ws6['filePhoto'];
    base64Front = ws6['base64Front'];
    file1 = ws6['file1'];
    base64Back = ws6['base64Back'];
    file2 = ws6['file2'];
    fileDoc = ws6['fileDoc'];
    base64Doc = ws6['base64Doc'];
    radioValue = ws6['radioValue'];
    user = ws6['userName'];
    email = ws6['email'];
    pass = ws6['password'];
    docID = int.parse(radioValue);
    
    super.didChangeDependencies();
  }
   
  _circleProg() {
    setState(() {
      _isLoading = true;
    });
  }

  _verifyOTP() async {
    var response = await EmailAuth.validate(receiverMail: email, userOTP: _otp.text);
    setState(() {
      _isLoading = true;
    });
    if (response) {
      print('OTP verified');
      try{
        await Services.addWorker(
              lname,
              fname,
              bdate,
              zone,
              barangay,
              filePhoto,
              base64Portrait,
              file1,
              base64Front,
              file2,
              base64Back,
              docID,
              fileDoc,
              base64Doc,
              user,
              email,
              pass)
          .then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WorkerHoldingScreen(),),);
      });
      }catch(error) {
        await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Connection Error.', style: TextStyle(color: Colors.black),),
                content: SingleChildScrollView(child:ListBody(children: [
                   Text('Please check your connection and try again.'),
                ],)),
                actions: <Widget>[
                  TextButton(
                    child: Center(child: Text('Ok', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
                    onPressed: () {
                      Navigator.of(context).pop();
                       setState(() {
                       _isLoading = false;
                     });
                    },
                  ),
                ],
          ),
          );
      }
    }else{
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Code does not match!', style: TextStyle(color: Colors.black),),
                content: SingleChildScrollView(child:ListBody(children: [
                   Text('Please enter the code sent to your email.'),
                ],)),
                actions: <Widget>[
                  TextButton(
                    child: Center(child: Text('Ok', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
                    onPressed: () {
                      Navigator.of(context).pop();
                       setState(() {
                       _isLoading = false;
                     });
                    },
                  ),
                ],
          ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  _isLoading
          ? loadingScreen(context, "Submitting application...") 
          : Scaffold(
      appBar:appBarSign(context, 'Email Verification'),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child:Column(
                                children: [
                              Form(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    controller: _otp,
                                    decoration:
                                        textFieldInputDecoration('Enter Code'),
                                  ),
                                ),
                              ),
                            SizedBox(height:10),
                            Text('A code was sent to your email, please enter the code sent.', style: TextStyle( color: Color.fromRGBO(62, 135, 148, 1),
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,),),
                                ],
                              ),
                            ),
                           // SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                //_circleProg();
                                _verifyOTP();
                              }, //() => workerSignUp(context),
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
                                  'Submit',
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
            ),
    );
  }
}
