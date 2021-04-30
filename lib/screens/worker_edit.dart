import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:io';
import 'dart:convert';

import '../styles/style.dart';
import '../widget/worker_change_modal.dart';
import '../services/services.dart';
import '../models/worker_edit.dart';


class WorkerEdit extends StatefulWidget {
  final int wid;
  WorkerEdit(this.wid);
  @override
  _WorkerEditState createState() => _WorkerEditState();
}

class _WorkerEditState extends State<WorkerEdit> {
  final _formKey = GlobalKey<FormState>();
  String bio;
  File _pickedImage;
  //File _storedImage;
  String filePhoto;
  String real64;
   var _isLoading = false;
  //TextEditingController _bio = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Edit Profile'),
      body: FutureBuilder<List<WorkerEdits>>(
        future: Services.getWorkerEdit(widget.wid),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List<WorkerEdits> workerEdit = snapshot.data;
            if(workerEdit.isNotEmpty){
              return Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  itemCount: workerEdit.length,
                  itemBuilder: (context, int index){
                    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
              GestureDetector(
               onTap: () => _startAddPhoto(context),
                child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 1, color: Theme.of(context).primaryColor),
                ),
                child:  _pickedImage != null
                ? Image.file(
                    _pickedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                :Image.network(workerEdit[index].profile),
              ),
            ),


            Divider(),
            SizedBox(height: 20),
            
            Form(
              key: _formKey,
                child: Column(
                children: [
                  TextFormField(
                    initialValue: workerEdit[index].bio,
                    //controller: _bio,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write your bio',
                    ),
                  maxLines: 5,
                  onSaved: (String value){
                    bio = value;
                  },
                  ),
                  //Icon(Icons.edit, size: 15),
                ],
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
                              onTap: () async{
                                ProgressDialog dialog = new ProgressDialog(context);
              dialog.style(
                message: 'Updating profile...',
              );
              await dialog.show();
                                _formKey.currentState.save();
                                await Services.updateBio(widget.wid, bio, filePhoto, real64).then((val){
                                  setState(() {
                  _isLoading = false;
                });
                dialog.hide();
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg:
                        "Success!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Color.fromRGBO(91, 168, 144, 1),
                    textColor: Colors.white,
                    fontSize: 14);
                                });

                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
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

          ],
           
        ),
      );
                  }
                ),
              );
            } 
          } else if (snapshot.hasError) {
                          return Column(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
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
     
        }
      ),
    );
  }
}