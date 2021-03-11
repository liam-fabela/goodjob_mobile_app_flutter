import 'package:flutter/material.dart';


import '../styles/style.dart';
import 'worker_home_screen.dart';



class LoginScreen extends StatefulWidget {
  // static const routeName = '/login';
  final Function toggle;

  LoginScreen(this.toggle);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController login_email = TextEditingController();
  TextEditingController login_password = TextEditingController();
   final formKey = GlobalKey<FormState>();
   var showPass = false;
    var obscure = true;

  void _login() {
     if(formKey.currentState.validate()){
        Navigator.of(context).pushReplacementNamed(
      WorkerHomeScreen.routeName
    );
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            Container(
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

                      controller: login_email,
                      decoration: textFieldInputDecoration('email'),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                           validator: (val) {
                              return val.isEmpty ? 'Please Enter Password' : null ;
                            },
                            controller: login_password,
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
                        onTap: ()=> _login(),
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
