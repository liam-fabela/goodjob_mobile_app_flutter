import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/style.dart';
import 'customer_otp.dart';

class Customer5SignUpScreen extends StatefulWidget {
  static const routeName = '/customer5_signup';
  @override
  _Customer5SignUpScreenState createState() => _Customer5SignUpScreenState();
}

class _Customer5SignUpScreenState extends State<Customer5SignUpScreen> {
  String lname;
  String fname;
  String bdate;
  String zone;
  String barangay;
  String userName;
  String email;
  String password;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _newpass = TextEditingController();
  //final TextEditingController _conpass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var showPass = false;
  var obscure = true;
  var _isLoading = false;
  static const url = 'https://goodjob-mobile-app.000webhostapp.com/customer_email_validate.php';
  //static const url = 'http://192.168.18.69/system/db_php/customer_email_validate.php';
  //static const url = 'http://192.168.18.29/db_php/customer_email_validate.php';

  @override
  void didChangeDependencies() {
    final ws5 =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    lname = ws5['lname'];
    fname = ws5['fname'];
    bdate = ws5['bdate'];
    zone = ws5['zone'];
    barangay = ws5['barangay'];
    super.didChangeDependencies();
  }

  Future<bool> _sendOTP(String email) async {
    EmailAuth.sessionName = "GoodJOB!";
    var response = await EmailAuth.sendOtp(receiverMail: email);
    return response;
  }

  Future<void> _checkUser(String mail) async {
    if (formKey.currentState.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        print("gisulod dne");
        var map = Map<String, dynamic>();
        map["searchEmail"] = _email.text;
        map["searchUsername"] = _username.text;

        http.Response response = await http.post(url,
            body: jsonEncode(map),
            headers: {'Content-type': 'application/json'});
        print('Login Response: ${response.body}');

        if (200 == response.statusCode) {
          print(response.body);
          var data = json.decode(response.body);
          if (data["error"]) {
            setState(() {
              _isLoading = false;
            });
            if (data["message"] == "email address already in use.") {
              print("NARA KO");
              Fluttertoast.showToast(
                  msg: data["message"],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14);
            }
           
          } else {
            
            _sendOTP(mail).then((response) {
              setState(() {
              _isLoading = false;
            });
              if (response) {
                Navigator.of(context)
                    .pushNamed(CustomerOTP.routeName, arguments: {
                  "lname": lname,
                  "fname": fname,
                  "bdate": bdate,
                  "zone": zone,
                  "barangay": barangay,
                  "email": _email.text,
                  "password": _newpass.text
                });
              } else {
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
                        Text('Please check your internet connection.'),
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
          }
        } else {
          return "error";
        }
      } catch (e) {
        print(e);
        throw (e);
      }
    }
  }

//     void _customerSignUp(BuildContext context, String mail) {
//    if(formKey.currentState.validate()) {
//    _sendOTP(mail);
//    Navigator.of(context).pushNamed(
//      CustomerOTP.routeName,
//      arguments: {
//        "lname": lname,
//        "fname": fname,
//        "bdate": bdate,
//        "zone": zone,
//        "barangay": barangay,
//        "userName": _username.text,
//        "email": _email.text,
//        "password": _newpass.text

//      }
//    );
//    }
  // }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? loadingScreen(context, "checking email...")
        : Scaffold(
            appBar: appBarSign(context, 'Customer Account Details'),
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
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 20.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            validator: (val) {
                                              if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(val) ==
                                                  false) {
                                                return 'Please Enter a Valid Email Address';
                                              }
                                              if (val.isEmpty) {
                                                return 'Please enter a Value';
                                              }
                                              return null;
                                            },
                                            controller: _email,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration:
                                                textFieldInputDecoration(
                                                    'Email Address'),
                                          ),
                                          Divider(),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: TextFormField(
                                                  validator: (val) {
                                                    if (val.length < 8) {
                                                      return 'Minimum of 8 characters!';
                                                    }
                                                    if (val.isEmpty) {
                                                      return 'Please Enter a Value';
                                                    }
                                                  },
                                                  controller: _newpass,
                                                  decoration:
                                                      textFieldInputDecoration(
                                                          'Enter Password'),
                                                  obscureText: obscure,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showPass = !showPass;
                                                    obscure = !obscure;
                                                  });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 50,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                                  child: showPass
                                                      ? Icon(
                                                          Icons.remove_red_eye,
                                                          color: Color.fromRGBO(
                                                              62, 135, 148, 1),
                                                        )
                                                      : Icon(
                                                          Icons.remove_red_eye),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _checkUser(_email.text),
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
            ),
          );
  }
}
