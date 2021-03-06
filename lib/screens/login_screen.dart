import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../styles/style.dart';
//import 'worker_home_screen.dart';
import 'customer_home_screen.dart';
import 'worker_holding_screen.dart';
import 'worker_categories_screen.dart';
//import '../services/services.dart';
import '../helper/shared_preferences.dart';
import 'forgot_password.dart';


class LoginScreen extends StatefulWidget {
  // static const routeName = '/login';
  final Function toggle;

  LoginScreen(this.toggle);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var showPass = false;
  var obscure = true;
  var _isLoading = false;
 static const url2 = 'https://goodjob-mobile-app.000webhostapp.com/login.php';
  ///static const url2 = 'http://192.168.18.69/system/db_php/login.php';
  //static const url2 = 'http://192.168.18.29/db_php/login.php';
  String utype;
  String valid;
  String userId;
  String firsTime;
  String lname;
  String fname;
//  String bday;
//  String zone;
//  String brgy;
//  String city;
//  String docId;
//  String usrname;

 
  Future<void> _loginUser() async {
    if (formKey.currentState.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        print("gisulod dne");
        var map = Map<String, dynamic>();
        map["searchEmail"] = loginEmail.text;
        map["searchPassword"] = loginPassword.text;

        http.Response response = await http.post(url2,
            body: jsonEncode(map),
            headers: {'Content-type': 'application/json'});
        print('Login Response: ${response.body}');

        if (200 == response.statusCode) {
          print(response.body);
          var data = json.decode(response.body);

          if (data["error"] && data["error2"]) {
            setState(() {
              _isLoading = false;
            });
            print("NARA KO");
            if (data["message"] == "No email found." &&
                data["message2"] == "No email found.") {
              print(data["message"]);
              Fluttertoast.showToast(
                  msg: data["message"],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14);
            }
            if (data["message"] == "No email found." ||
                data["message2"] == "Your Password is incorrect.") {
              print(data["message2"]);
              Fluttertoast.showToast(
                  msg: data["message2"],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14);
            }
            if (data["message"] == "Your Password is incorrect." ||
                data["message2"] == "No email found.") {
              print(data["message"]);
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
            if(data["deleted"] || data["deleted2"]){
              Fluttertoast.showToast(
                  msg: "Your account is deleted!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14);
            }
            utype = data["usertype"];
            valid = data["validate"];
            userId = data["uid"];
            firsTime = data["first"];
            lname = data["lastname"];
            fname = data["firstname"];

            // int workerId = int.parse(userId);
            int type = int.parse(utype);
            int validity = int.parse(valid);
            int first = int.parse(firsTime);
            int uId = int.parse(userId);
            String userName = fname + " " + lname;
            if (type == 1) {
              if (validity == 1 && first == 1) {
                  SharedPrefUtils.setPref('user', type);
                   SharedPrefUtils.setUserId('userId', uId);
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  // prefs.setInt('user', type);
                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginEmail.text, password: loginPassword.text)
                            .then((value){
                               Navigator.of(context).pushReplacementNamed(
                      WorkerCategoryScreen.routeName,
                      arguments: {
                        "workerId": userId,
                        // "username": usrname,
                      });
                  print(userId);
                            }).catchError((error){
                               var errorCode = error.code;
                              var errorMessage = error.message;
                              if(errorCode == 'ERROR 17020'){
                                Fluttertoast.showToast(
                               msg: errorMessage,
                               toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                 timeInSecForIosWeb: 2,
                               backgroundColor: Colors.grey,
                               textColor: Colors.red,
                             );
                              }else{
                                Fluttertoast.showToast(
                               msg: errorMessage,
                               toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                 timeInSecForIosWeb: 2,
                               backgroundColor: Colors.grey,
                               textColor: Colors.red,
                             );
                              }
                            });
                 
              
              } else if (validity == 1 && first == 0) {
                  SharedPrefUtils.setPref('user', type);
                  SharedPrefUtils.setUserId('userId', uId);
                  SharedPrefUtils.setUserName('userName', userName);
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  //prefs.setInt('user', type);
                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginEmail.text, password: loginPassword.text)
                            .then((value){
                               Navigator.pushReplacementNamed(context,'/worker_home');
                              // Navigator.of(context).pushReplacementNamed('/worker_home');
                            }).catchError((error){
                                setState(() {
                                _isLoading = false;
                              });

                              var errorCode = error.code;
                              var errorMessage = error.message;
                              if(errorCode == 'ERROR 17020'){
                                Fluttertoast.showToast(
                               msg: errorMessage,
                               toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                 timeInSecForIosWeb: 2,
                               backgroundColor: Colors.grey,
                               textColor: Colors.red,
                             );
                              }else{
                                Fluttertoast.showToast(
                               msg: errorMessage,
                               toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                 timeInSecForIosWeb: 2,
                               backgroundColor: Colors.grey,
                               textColor: Colors.red,
                             );
                              }
                            });
                 
                
              } else {
                  Navigator.of(context)
                      .pushReplacementNamed(WorkerHoldingScreen.routeName);
              
              }
            }
            if (type == 2) {
                SharedPrefUtils.setPref('user', type);
                SharedPrefUtils.setUserId('userId', uId);
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.setInt('userId', type);
                await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginEmail.text, password: loginPassword.text)
                            .then((value){
                             Navigator.pushReplacementNamed(context,CustomerHomeScreen.routeName);
                  //           Navigator.pushNamedAndRemoveUntil(context,
                  //  '/customer_home', (_) => false);
                            }).catchError((error){
                               var errorCode = error.code;
                              var errorMessage = error.message;
                              if(errorCode == 'ERROR 17020'){
                                Fluttertoast.showToast(
                               msg: errorMessage,
                               toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                 timeInSecForIosWeb: 2,
                               backgroundColor: Colors.grey,
                               textColor: Colors.red,
                             );
                              }else{
                                Fluttertoast.showToast(
                               msg: errorMessage,
                               toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                 timeInSecForIosWeb: 2,
                               backgroundColor: Colors.grey,
                               textColor: Colors.red,
                             );
                              }
                            });
                
            
            }
          }
        } else {
          print("error");
        }
      } catch (e) {
        print('catch part: $e');
        await showDialog(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? loadingScreen(context, "Signing in...")
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 40,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Image.asset(
                              'assets/images/good_job.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          //SizedBox(height: 20),
                          Center(child: Text('GoodJob!', style:logoFont()))
                        ],
                      ),
                      
                    ),
                //    Expanded(
                //      flex: 10,
               //       child: Center(child: Text('GoodJob!', style:logoFont()))),
                    Expanded(
                      flex: 60,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Form(
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
                                    child: Column(children: <Widget>[
                                      TextFormField(
                                        validator: (val) {
                                          return val.isEmpty
                                              ? 'Please Enter Email'
                                              : null;
                                        },
                                        controller: loginEmail,
                                        keyboardType:
                                                TextInputType.emailAddress,
                                        decoration:
                                            textFieldInputDecoration('email'),
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              validator: (val) {
                                                return val.isEmpty
                                                    ? 'Please Enter Password'
                                                    : null;
                                              },
                                              controller: loginPassword,
                                              obscureText: obscure,
                                              decoration:
                                                  textFieldInputDecoration(
                                                      'password'),
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
                                                  : Icon(Icons.remove_red_eye),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasword()),);
                                    },
                                      child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () => _loginUser(),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(62, 135, 148, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Sign in',
                                        style: mediumTextStyle(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Don\'t have an account? ',
                                        style: mediumTextStyle(),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          widget.toggle();
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text(
                                            'Register now',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
