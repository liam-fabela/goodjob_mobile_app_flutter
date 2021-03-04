import 'package:flutter/material.dart';

import '../styles/style.dart';

class Worker7SignUp extends StatefulWidget {
  static const routeName = '/worker7_signup';

  @override
  _Worker7SignUpState createState() => _Worker7SignUpState();
}

class _Worker7SignUpState extends State<Worker7SignUp> {
    final TextEditingController _username = TextEditingController();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _newpass = TextEditingController();
     //final TextEditingController _conpass = TextEditingController();
     final formKey = GlobalKey<FormState>();

    void workerSignUp(BuildContext context) {
    if(formKey.currentState.validate()) {
    Navigator.of(context).pushNamed(
      Worker7SignUp.routeName
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Worker Account Details'),
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
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                 child:  Column(
                                   
                                    children: <Widget>[
                                    
                                      TextFormField(
                                        validator: (val) {
                                             if(val.isEmpty  ) {
                                                   return 'Please Enter a Value';
                                             }
                                             if(val.length < 4){
                                               return 'Minimnum of 4 characters!';
                                             }
                                               return null;
                                          

                                        },
                                        controller: _username,
                                        decoration:
                                            textFieldInputDecoration('User Name'),
                                      ),
                                      Divider(),
                                      TextFormField(
                                         validator: (val) {
                                             if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) == false) {
                                                   return 'Please Enter a Valid Email Address';
                                             }if(val.isEmpty){
                                                return 'Please enter a Value';
                                            }
                                            return null;
                                          

                                        },
                                        controller: _email,
                                        decoration:
                                            textFieldInputDecoration('Email Address'),
                                      ),
                                      Divider(),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: TextFormField(
                                               validator: (val) {
                                                if(val.length < 8){
                                               return 'Minimum of 8 characters!';
                                                }
                                                if(val.isEmpty){
                                               return 'Please Enter a Value';
                                               }
                                               },
                                              controller: _newpass,
                                              decoration:
                                                  textFieldInputDecoration('Enter Password'),
                                                  obscureText: true,
                                            ),
                                          ),
                                           GestureDetector(
                                              onTap: (){},
                                              child: Container(
                                                height: 40,
                                                width: 50,
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Icon(Icons.remove_red_eye),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],),
                              ),
                            ],
                          ),
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
      ),
    );
  }
}
