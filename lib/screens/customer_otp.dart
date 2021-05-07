import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:ntp/ntp.dart';

import '../styles/style.dart';
import '../services/services.dart';
//import 'customer_home_screen.dart';
import '../helper/authenticate.dart';

class CustomerOTP extends StatefulWidget {
  static const routeName = '/customer_otp';
  @override
  _CustomerOTPState createState() => _CustomerOTPState();
}

class _CustomerOTPState extends State<CustomerOTP> {
  
  String lname;
  String fname;
  String bdate;
  String zone;
  String barangay;
  String email;
  String pass;
  TextEditingController _otp = TextEditingController();
  var _isLoading = false;
  String firebaseUser;


   @override
  void didChangeDependencies() {
    final ws6 =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    lname = ws6['lname'];
    fname = ws6['fname'];
    bdate = ws6['bdate'];
    zone = ws6['zone'];
    barangay = ws6['barangay'];
    email = ws6['email'];
    pass = ws6['password'];
    super.didChangeDependencies();
  }

  _saveToFirebase() async{
     var response = EmailAuth.validate(receiverMail: email, userOTP: _otp.text);
    setState(() {
      _isLoading = true;
    });
    if(response){
    FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: email,
            password: pass,
          ).then((authResults) {
            print('SUCCESSFULLY SIGNED UP');
            firebaseUser = authResults.user.uid;
            var userProfile = {
              'uid': authResults.user.uid,
              'lname': lname,
              'fname': fname,
              'email': email,
              'image':
                  'https://firebasestorage.googleapis.com/v0/b/good-job-project.appspot.com/o/worker_profile%2Fprofile.png?alt=media&token=90b1494f-e6b7-4379-aa57-b2ce62c37ba5',
            };
            print('continued here');

           FirebaseDatabase.instance
                .reference()
                .child("users/" + authResults.user.uid)
                .set(userProfile)
                .then((val) {
                   print('FIREBASE TIME SECOND');
                _verifyOTP();
              
            
            }).catchError((error) {
              print('NAG ERROR DNE SA FIREDB');
              var errorCode = error.code;
              var errorMessage = error.message;
              if (errorCode == 'ERROR 17020') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Connection Error.',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: SingleChildScrollView(
                        child: ListBody(
                      children: [
                        Text('Please check your connection and try again.'),
                      ],
                    )),
                    actions: <Widget>[
                      TextButton(
                        child: Center(
                          child: Text(
                            'Ok',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
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
              }else{
                showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Something went wrong.', style: TextStyle(color: Colors.black),),
                content: SingleChildScrollView(child:ListBody(children: [
                   Text(errorMessage),
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
            });
          }).catchError((error) {
             print('NAG ERROR DNE SA FIREAUTH');
            var errorCode = error.code;
            var errorMessage = error.message;
            if(errorCode == 'ERROR 17020'){
               showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Connection Error.',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: SingleChildScrollView(
                        child: ListBody(
                      children: [
                        Text('Please check your connection and try again.'),
                      ],
                    )),
                    actions: <Widget>[
                      TextButton(
                        child: Center(
                          child: Text(
                            'Ok',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
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
            }else{
               showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Something went wrong.',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: SingleChildScrollView(
                        child: ListBody(
                      children: [
                        Text(errorMessage),
                      ],
                    )),
                    actions: <Widget>[
                      TextButton(
                        child: Center(
                          child: Text(
                            'Ok',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
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
          });
    } else{
      await showDialog(
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

   _verifyOTP() async {
      try{
         var join = await NTP.now();
      String joined = join.toString();
        await Services.addCustomer(
              lname,
              fname,
              bdate,
              zone,
              barangay,
              email,
              pass,
              firebaseUser,
              joined,
              )
          .then((value) {
            print('gisulod sa otp');
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Registration Successful.',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: SingleChildScrollView(
                        child: ListBody(
                      children: [
                        Text('Please click ok to login'),
                      ],
                    )),
                    actions: <Widget>[
                      TextButton(
                        child: Center(
                          child: Text(
                            'Ok',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        onPressed: () {
                           Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Authenticate(),),);
                         
                        },
                      ),
                    ],
                  ),
                );
           
      });
    }catch(error){
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Connection error.',style: TextStyle(color: Colors.black),),
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
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarSign(context, 'Email Verification'),
      body: _isLoading
          ? loadingScreen(context, "Signing up...")
          : SingleChildScrollView(
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
                              Form(
                                child: Expanded(
                                  child: Column(
                                    children: [
                                  Container(
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
                               
                             SizedBox(height:10),
                            Text('A code was sent to your email, please enter the code sent.', style: TextStyle( color: Color.fromRGBO(62, 135, 148, 1),
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,),),
                                   ],
                                  ),
                                ),
                              ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                //_circleProg();
                               _saveToFirebase();
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

