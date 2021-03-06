import 'package:flutter/material.dart';


import '../styles/style.dart';
//import 'worker3_sign_up.dart';
import 'worker4_sign_up.dart';

class Worker2SignUp extends StatefulWidget {
  static const routeName = '/worker2_signup';
  //final String fname;
  //final String lname;
  //final String bdate;

  //Worker2SignUp(this.fname, this.lname, this.bdate);
  
  @override
  _Worker2SignUpState createState() => _Worker2SignUpState();
}

class _Worker2SignUpState extends State<Worker2SignUp> {
    final TextEditingController _street = TextEditingController();
    final TextEditingController _barangay = TextEditingController();
     final TextEditingController _cityOrMuni = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String lname;
    String fname;
    String bdate;


    @override
  void didChangeDependencies() {
    final ws1 = ModalRoute.of(context).settings.arguments as Map<String, String>;
    lname = ws1['lname'];
    fname = ws1['fname'];
    bdate = ws1['bdate'];
    
    super.didChangeDependencies();
  }

   
   void workerSignUp(BuildContext context) {
  if(formKey.currentState.validate()){
    Navigator.of(context).pushNamed(
      Worker4SignUp.routeName,
      arguments: {
        'lname': lname,
        'fname': fname,
        'bdate': bdate,
        'addr': _street.text + ' ' + _barangay.text + ' ' + _cityOrMuni.text,


      }
    );
    
  }
    //print(lname2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Worker Complete Address'),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: Container(
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    
                                    TextFormField(
                                      validator: (val) {
                                        return val.isEmpty ? 'Please Enter a Value' : null ;                 
                                       },
                                      controller: _street,
                                      decoration:
                                          textFieldInputDecoration('Street/Zone'),
                                    ),
                                    Divider(),
                                    TextFormField(
                                       validator: (val) {
                                        return val.isEmpty ? 'Please Enter a Value' : null ;                 
                                       },
                                      controller: _barangay,
                                      decoration:
                                          textFieldInputDecoration('Barangay'),
                                    ),
                                    Divider(),
                                    TextFormField(
                                       validator: (val) {
                                        return val.isEmpty ? 'Please Enter a Value' : null ;                 
                                       },
                                      controller: _cityOrMuni,
                                      decoration: textFieldInputDecoration(
                                          'City/Municipality'),
                                    ),
                                  ],
                                ),
                              ),
                              
                             
                            ],
                          )),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
