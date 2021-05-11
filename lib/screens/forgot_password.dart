import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../styles/style.dart';
import '../services/services.dart';

class ForgotPasword extends StatefulWidget {
  @override
  _ForgotPaswordState createState() => _ForgotPaswordState();
}

class _ForgotPaswordState extends State<ForgotPasword> {
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var showPass = false;
  var obscure = true;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    updatePassword() async {
      ProgressDialog dialog = new ProgressDialog(context);
      dialog.style(
        message: 'Resetting Password...',
      );
      await dialog.show();
      await Services.resetPassword(loginEmail.text, loginPassword.text)
          .then((value) {
        firebaseAuth.sendPasswordResetEmail(email: loginEmail.text).then((val) {
          dialog.hide();
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(
                'IMPORTANT NOTICE!',
                style: TextStyle(color: Colors.black),
              ),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  Text(
                      'An email will be sent to you and will ask for your new password. Please enter the password to successfully reset your password.'),
                ],
              )),
              actions: <Widget>[
                TextButton(
                  child: Center(
                    child: Text(
                      'Okay',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); 
                   

                  },
                ),
              ],
            ),
          );
          
        });
      });

    }

    return Scaffold(
      appBar: appBarSign(context, 'Forgot Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
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
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (val) {
                                  return val.isEmpty
                                      ? 'Please Enter Email'
                                      : null;
                                },
                                controller: loginEmail,
                                keyboardType: TextInputType.emailAddress,
                                decoration: textFieldInputDecoration('Email'),
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
                                      decoration: textFieldInputDecoration(
                                          'Enter new password'),
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
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            updatePassword();
                          },
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
                              'Reset Password',
                              style: mediumTextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
