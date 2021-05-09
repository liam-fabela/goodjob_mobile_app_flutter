import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../styles/style.dart';
import '../widget/worker_change_modal.dart';
import '../services/services.dart';
import '../models/worker_edit.dart';
import '../helper/shared_preferences.dart';

class WorkerEdit extends StatefulWidget {
  final int wid;
  WorkerEdit(this.wid);
  @override
  _WorkerEditState createState() => _WorkerEditState();
}

class _WorkerEditState extends State<WorkerEdit> {
  final _formKey = GlobalKey<FormState>();
  String bio;
  String zone;
  String brgy;
  String pass;
  File _pickedImage;
  //File _storedImage;
  String filePhoto;
  String real64;
  var _isLoading = false;
  var obscure = true;
  var showPass = false;
  var obscure2 = true;
  var showPass2 = false;
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
   static const url =
      'https://goodjob-mobile-app.000webhostapp.com/worker_change_password.php';

  //TextEditingController _bio = TextEditingController();
  //
  @override
  void initState() {
    filePhoto = "";
    real64 = "";
    super.initState();
  }

  void _selectImage(File pickedImage, String fileName) {
    filePhoto = fileName;
    setState(() {
      _pickedImage = pickedImage;
    });

    real64 = base64Encode(_pickedImage.readAsBytesSync());
  }

  void _startAddPhoto(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: WorkerChangeModal(_selectImage),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

   Future<String> _updatePassword(int wid, String oldp, String newp) async {
    try {
      setState(() {
        _isLoading = true;
      });
      print("gisulod dne");
     
      var map = Map<String, dynamic>();
      map["wid"] = wid;
      map["oldPass"] = oldp;
      map["newPass"] = newp;

      http.Response response = await http.post(url,
          body: jsonEncode(map), headers: {'Content-type': 'application/json'});
      print('Login Response: ${response.body}');

      if (200 == response.statusCode) {
        print(response.body);
        var data = json.decode(response.body);
        if (data["status"] == "ok") {
          final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          User currentUser = firebaseAuth.currentUser;

          currentUser.updatePassword(newp).then((_){
            return data["status"];
          }).catchError((error){
            print("An error has occured");
          });
          return data["status"];
          //('ok');
        } else {
          return data["status"];
        }
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Edit Profile'),
      body: FutureBuilder<List<WorkerEdits>>(
          future: Services.getWorkerEdit(widget.wid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<WorkerEdits> workerEdit = snapshot.data;
              if (workerEdit.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: workerEdit.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => _startAddPhoto(context),
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: _pickedImage != null
                                      ? Image.file(
                                          _pickedImage,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                      : Image.network(
                                          workerEdit[index].profile,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 20),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        initialValue: workerEdit[index].bio,
                                        //controller: _bio,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'About',
                                          hintText: 'Write your bio',
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        maxLines: 3,
                                        onSaved: (String value) {
                                          bio = value;
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        initialValue: workerEdit[index].zone,
                                        //controller: _bio,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Zone',
                                          hintText: '',
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        onSaved: (String value) {
                                          zone = value;
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        initialValue:
                                            workerEdit[index].barangay,
                                        //controller: _bio,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Barangay',
                                          hintText: '',
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        onSaved: (String value) {
                                          brgy = value;
                                        },
                                      ),
                                        SizedBox(height: 30),
                              GestureDetector(
                                onTap: () async {
                                  ProgressDialog dialog =
                                      new ProgressDialog(context);
                                  dialog.style(
                                    message: 'Updating profile...',
                                  );
                                  await dialog.show();
                                  _formKey.currentState.save();
                                  if (filePhoto == "" && real64 == "") {
                                    await Services.updateBio2(
                                            widget.wid, bio, zone, brgy, pass)
                                        .then((val) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      dialog.hide();
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "Success!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor:
                                              Color.fromRGBO(91, 168, 144, 1),
                                          textColor: Colors.white,
                                          fontSize: 14);
                                    });
                                  } else {
                                    await Services.updateBio(widget.wid, bio,
                                            filePhoto, real64, zone, brgy, pass)
                                        .then((val) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      dialog.hide();
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "Success!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor:
                                              Color.fromRGBO(91, 168, 144, 1),
                                          textColor: Colors.white,
                                          fontSize: 14);
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(62, 135, 148, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                                      Divider(),
                                      Text('Change Password',
                                          style: profileName()),
                                      SizedBox(height: 20),

                                      SizedBox(height: 10),
                                      Container(
                                        //  height: MediaQuery.of(context).size.height * 0.65,
                                        // alignment: Alignment.bottomCenter,
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 20.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: oldPass,
                                                  decoration:
                                                      textFieldInputDecoration(
                                                          'Enter old password'),
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
                                          Divider(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: newPass,
                                                  decoration:
                                                      textFieldInputDecoration(
                                                          'Enter new password'),
                                                  obscureText: obscure2,
                                                  
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showPass2 = !showPass2;
                                                    obscure2 = !obscure2;
                                                  });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 50,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                                  child: showPass2
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
                                        ]),
                                      ),
                                      SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () async {
                                          ProgressDialog dialog =
                                              new ProgressDialog(context);
                                          dialog.style(
                                            message: 'Updating password...',
                                          );
                                          await dialog.show();

                                          await _updatePassword(widget.wid,
                                                  oldPass.text, newPass.text)
                                              .then((val) {
                                            if (val.toString() == "ok") {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              dialog.hide();
                                            //  Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                    'Log out.',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: ListBody(
                                                    children: [
                                                      Text(
                                                          'You need to logout in order for the password change to take effect.'),
                                                    ],
                                                  )),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Center(
                                                        child: Text(
                                                          'Okay',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        SharedPrefUtils
                                                            .removePref();
                                                        Navigator.of(context)
                                                            .pushNamedAndRemoveUntil(
                                                                '/',
                                                                (Route<dynamic>
                                                                        route) =>
                                                                    false);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              dialog.hide();
                                             // Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "The old password is incorrect!",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 2,
                                                  backgroundColor: Color.fromRGBO(
                                                      91, 168, 144, 1),
                                                  textColor: Colors.white,
                                                  fontSize: 14);
                                            }
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.3,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(62, 135, 148, 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            'Update',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),

                                     
                                      //Icon(Icons.edit, size: 15),
                                    ],
                                  ),
                                ),
                              ),
                            
                            ],
                          ),
                        );
                      }),
                );
              }
            } else if (snapshot.hasError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off_outlined,
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Connection error.',
                    style: TextStyle(
                      color: Color.fromRGBO(62, 135, 148, 1),
                      fontSize: 12,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      // _refreshData(widget.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(62, 135, 148, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Try Again',
                        style: mediumTextStyle(),
                      ),
                    ),
                  ),
                ],
              );
            }
            return loadingScreen(context, 'loading...');
          }),
    );
  }
}
