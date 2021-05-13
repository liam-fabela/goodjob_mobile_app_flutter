import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/style.dart';
import 'customer2_sign_up.dart';

class CustomerSignUpScreen extends StatefulWidget {
  static const routeName = '/customer_signup';
  @override
  _CustomerSignUpScreenState createState() => _CustomerSignUpScreenState();
}

class _CustomerSignUpScreenState extends State<CustomerSignUpScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;
  final formKey = GlobalKey<FormState>();
  String formatted;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1901, 1),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        var date = '${DateFormat.yMd().format(_selectedDate)}';
        _dateController.text = date;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        formatted = formatter.format(_selectedDate);
        print(formatted);
      });
    });
  }

  

  void _customerSignUp(BuildContext context) {
    if (formKey.currentState.validate()) {
      Navigator.of(context)
          .pushNamed(Customer2SignUpScreen.routeName, arguments: {
        'lname': _lastName.text,
        'fname': _firstName.text,
        'bdate': formatted,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Customer Personal Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              children: [
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
                      children: [
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
                                          return val.isEmpty
                                              ? 'Please Enter a Value'
                                              : null;
                                        },
                                        controller: _firstName,
                                        decoration: textFieldInputDecoration(
                                            'First Name'),
                                      ),
                                      Divider(),
                                      TextFormField(
                                        validator: (val) {
                                          return val.isEmpty
                                              ? 'Please Enter a Value'
                                              : null;
                                        },
                                        controller: _lastName,
                                        decoration: textFieldInputDecoration(
                                            'Last Name'),
                                      ),
                                      Divider(),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              validator: (val) {
                                                return val.isEmpty
                                                    ? 'Please Enter a Value'
                                                    : null;
                                              },
                                              controller: _dateController,
                                              decoration:
                                                  textFieldInputDecoration(
                                                      'Date of Birth'),
                                              //keyboardType: TextInputType.datetime,
                                              readOnly: true,
                                              onTap: _presentDatePicker,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: _presentDatePicker,
                                            child: Container(
                                              height: 40,
                                              width: 50,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: Image.asset(
                                                'assets/images/calendar.png',
                                                fit: BoxFit.cover,
                                              ),
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
                          onTap: () {
                            if(formatted != null){
                              var dateNow = DateTime.now();
                            var dob = DateTime.parse(formatted);
                            var diff = dateNow.difference(dob);
                            var year = ((diff.inDays)/365).round();
                            if(year < 18){
                               Fluttertoast.showToast(
                                  msg:
                                      "Ages below 18 is not allowed to register",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 14);
                              return;
                            }
                            }
                             
                            _customerSignUp(context);
                          },
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
                          //     ),
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
