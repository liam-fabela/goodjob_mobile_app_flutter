import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../services/services.dart';

class Worker7SignUp extends StatefulWidget {
  static const routeName = '/worker7_signup';

  @override
  _Worker7SignUpState createState() => _Worker7SignUpState();
}

class _Worker7SignUpState extends State<Worker7SignUp> {
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

    final TextEditingController _username = TextEditingController();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _newpass = TextEditingController();
     //final TextEditingController _conpass = TextEditingController();
     final formKey = GlobalKey<FormState>();
    

    @override
  void didChangeDependencies() {
    final ws5 = ModalRoute.of(context).settings.arguments as Map<String, String>;
    lname = ws5['lname'];
    fname = ws5['fname'];
    bdate = ws5['bdate'];
    zone = ws5['zone'];
    barangay = ws5['barangay'];
    base64Portrait = ws5['base64Portrait'];
    filePhoto = ws5['filePhoto'];
    base64Front = ws5['base64Front'];
    file1 = ws5['file1'];
    base64Back = ws5['base64Back'];
    file2 = ws5['file2'];
    fileDoc = ws5['fileDoc'];
    base64Doc = ws5['base64Doc'];
    radioValue = ws5['radioValue'];
    docID = int.parse(radioValue);
    super.didChangeDependencies();
  }

  
   _addWorker() {
     print(filePhoto);
     print('working');
    Services.addWorker(lname, fname, bdate, zone, barangay, filePhoto, base64Portrait, file1, base64Front, file2, base64Back, docID, fileDoc, base64Doc, _username.text, _email.text, _newpass.text);
      
  }



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
                                              onTap:(){},
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
                              onTap:  (){
                                   _addWorker();
                                     },//() => workerSignUp(context),
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
