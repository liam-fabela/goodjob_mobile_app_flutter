import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

import '../styles/style.dart';
import '../services/services.dart';
import 'customer_home_screen.dart';

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
    user = ws6['userName'];
    email = ws6['email'];
    pass = ws6['password'];
    super.didChangeDependencies();
  }

   _verifyOTP() {
    var response = EmailAuth.validate(receiverMail: email, userOTP: _otp.text);
    setState(() {
      _isLoading = true;
    });
    if (response) {
      print('OTP verified');
      Services.addCustomer(
              lname,
              fname,
              bdate,
              zone,
              barangay,
              user,
              email,
              pass)
          .then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CustomerHomeScreen(),),);
      });
    }else{
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Wrong Code!', style: TextStyle(color: Colors.black),),
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
    return Scaffold(
      appBar:appBarSign(context, 'Email Verification'),
      body: _isLoading
          ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )  
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
                            SizedBox(height: 20),
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

