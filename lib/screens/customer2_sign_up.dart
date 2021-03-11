import 'package:flutter/material.dart';

import '../styles/style.dart';
import 'customer3_sign_up.dart';

class Customer2SignUpScreen extends StatefulWidget {
   static const routeName = '/customer2_signup';
  @override
  _Customer2SignUpScreenState createState() => _Customer2SignUpScreenState();
}

class _Customer2SignUpScreenState extends State<Customer2SignUpScreen> {

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
void _customerSignUp(BuildContext context) {
  if(formKey.currentState.validate()){
    Navigator.of(context).pushNamed(
      Customer3SignUpScreen.routeName,
      arguments: {
        'lname': lname,
        'fname': fname,
        'bdate': bdate,
        'zone': _street.text,
        'barangay': _barangay.text,
      }
    );
    
  }
    //print(lname2);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: appBarSign(context, 'Customer Complete Address'),
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
                              onTap: () => _customerSignUp(context),
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