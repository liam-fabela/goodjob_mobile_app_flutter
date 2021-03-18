import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styles/style.dart';
import 'worker_home_screen.dart';
import 'customer_home_screen.dart';
import 'worker_holding_screen.dart';
import 'worker_categories_screen.dart';
//import '../services/services.dart';
import '../helper/shared_preferences.dart';






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
  static const url2 ='http://192.168.43.250/db_php/login.php';
  String utype;
  String valid;
  String userId;
  String firsTime;
  String lname;
  String fname;
  String bday;
  String zone;
  String brgy;
  String city;
  String docId;
  String usrname;

  
  Future<void> _loginUser() async {
     if(formKey.currentState.validate()){
     try{

        setState(() {
      _isLoading = true;
    });
       print("gisulod dne");
       var map = Map<String, dynamic>();
        map["searchEmail"] = loginEmail.text;
        map["searchPassword"] = loginPassword.text;

      
       http.Response response = await http.post(url2, body:jsonEncode(map), headers: {'Content-type': 'application/json'});
       print('Login Response: ${response.body}');

      if (200 == response.statusCode) {
        print(response.body);
        var data = json.decode(response.body);
       
        if(data["error"] && data["error2"]){
           setState(() {
          _isLoading = false;
        });
          print("NARA KO");
          if(data["message"] == "No email or username found." && data["message2"] ==  "No email or username found." ){
            print(data["message"]);
            Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 14
            );
          } 
          if(data["message"] == "No email or username found." && data["message2"] ==   "Your Password is incorrect."){
            print(data["message2"]);
             Fluttertoast.showToast(
              msg: data["message2"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 14
            );
          }
          if(data["message"] == "Your Password is incorrect." && data["message2"] == "No email or username found.") {
            print(data["message"]);
             Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 14
            );
          }

        
        }

        utype = data["usertype"];
        valid = data["validate"];
        userId = data["uid"];
        firsTime = data["first"];
        lname = data["lastname"];
        fname = data["firstname"];
        bday = data["birthdate"];
        zone = data["zone"];
        brgy= data["barangay"];
        city  = data["city"];
        docId = data["docId"];
        usrname = data["username"];
       // int workerId = int.parse(userId);
        int type = int.parse(utype);
        int validity = int.parse(valid);
        int first = int.parse(firsTime);
        if(type == 1){
          if(validity == 1 && first == 1){
            SharedPrefUtils.setPref('user', type);
           // SharedPreferences prefs = await SharedPreferences.getInstance();
           // prefs.setInt('user', type);
             Navigator.of(context).pushReplacementNamed(
           '/worker_home',
            arguments: {
              "workerId": userId,
              "username": usrname,
            }
          );
          print(userId);
          }
          else if(validity == 1 && first == 0){
             SharedPrefUtils.setPref('user', type);
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            //prefs.setInt('user', type);
             Navigator.of(context).pushReplacementNamed(
            WorkerHomeScreen.routeName,
            arguments: {
              "workerId": userId,
              "username": usrname,
            }
          );
          }
          else{
             Navigator.of(context).pushReplacementNamed(
            WorkerHoldingScreen.routeName
          );
          }
           
        }
        if(type ==2){
           SharedPrefUtils.setPref('user', type);
           //SharedPreferences prefs = await SharedPreferences.getInstance();
            //prefs.setInt('user', type);
           Navigator.of(context).pushReplacementNamed(
          CustomerHomeScreen.routeName
          );
        }
       
        
       
      } else {
      return "error";
    }
     }catch(e){
       print(e);
       throw(e);
     }
  }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? loadingScreen(context,"Signing in...") :
          SingleChildScrollView(
          child: Column(
            
          children: <Widget>[

            Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.35,
            child: Image.asset(
            'assets/images/good_job.png',
             fit: BoxFit.cover,
            ),
            ),
            SizedBox(height: 30),
           Container(
              height: MediaQuery.of(context).size.height - 70,
              alignment: Alignment.bottomCenter,
               padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                Form(
                   key: formKey,
                  child: Column(children: <Widget>[
                    Container(
                     alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                    child: Column(
                    children: <Widget>[
                    TextFormField(
                       validator: (val) {
                        return val.isEmpty ? 'Please Enter Email' : null ;                 
                        },

                      controller: loginEmail,
                      decoration: textFieldInputDecoration('email/username'),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                           validator: (val) {
                              return val.isEmpty ? 'Please Enter Password' : null ;
                            },
                            controller: loginPassword,
                            obscureText: obscure,
                            decoration: textFieldInputDecoration('password'),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                             setState(() {
                                showPass = !showPass;
                                obscure = !obscure;

                               });
                              },
                                              child: Container(
                                                height: 40,
                                                width: 50,
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                              child: showPass ? Icon(Icons.remove_red_eye, color: Color.fromRGBO(62, 135, 148, 1),) : Icon(Icons.remove_red_eye),
                                            ),
                                          ),
                      ],
                    ),
                    ]
                    ),
                    ),
                     SizedBox(
                        height: 8,
                      ),
                       Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        'Forgot Password?',
                       style:  TextStyle(
                                  color: Colors.white, 
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,),
                      ),
                    ),
                    SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: ()=> _loginUser(),
                            child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 20,),
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
                       SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Text('Don\'t have an account? ', style:  mediumTextStyle(),),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                            child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('Register now', style:  TextStyle(
                                  color: Colors.white, 
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                            ),),
                          ),
                        ),
                      ],),
                      SizedBox(height: 50,),
                  ],
                ),
                ),
                ], 
              ),
          ),
           
           ],
        ),
      ),
      );
      
    
  }
}
