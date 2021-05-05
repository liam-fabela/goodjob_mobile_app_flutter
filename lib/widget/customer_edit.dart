import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:io';
import 'dart:convert';

import '../styles/style.dart';
import 'customer_change_modal.dart';
import '../models/customer_edits.dart';
import '../services/services.dart';



class CustomerEdit extends StatefulWidget {
  final int cid;
  CustomerEdit(this.cid);
  @override
  _CustomerEditState createState() => _CustomerEditState();
}

class _CustomerEditState extends State<CustomerEdit> {
  final _formKey = GlobalKey<FormState>();
  String barangay;
  String zone;
  String pass;
   File _pickedImage;
  //File _storedImage;
  String filePhoto;
  String real64;
  var _isLoading = false;

  @override
  void initState() {
    filePhoto="";
    real64="";
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
          child: CustomerModal(_selectImage),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context,'Edit Profile'),
      body: FutureBuilder<List<CustomerEdits>>(
        future: Services.getCustomerEdit(widget.cid),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List<CustomerEdits> customerEdit = snapshot.data;
            if(customerEdit.isNotEmpty){
              return Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: customerEdit.length,
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
                :Image.network(customerEdit[index].profile, fit: BoxFit.cover,
                    width: double.infinity,),
              ),
            ),


            Divider(),
            SizedBox(height: 20),
            
            Form(
              key: _formKey,
                child: Column(
                children: [
                  TextFormField(
                     initialValue: customerEdit[index].zone,
                    //controller: _bio,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Zone',
                      hintText: '',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  onSaved: (String value){
                    zone = value;
                  },
                  ),
                   SizedBox(height: 10),
                  TextFormField(
                     initialValue:customerEdit[index].barangay,
                    //controller: _bio,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Barangay',
                      hintText: '',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  onSaved: (String value){
                    barangay = value;
                  },
                  ),
                   SizedBox(height: 10),
                  TextFormField(
                     initialValue: customerEdit[index].password,
                    //controller: _bio,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: '',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    obscureText: true,
                  onSaved: (String value){
                    pass = value;
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
              if(filePhoto == "" && real64 == "") { 
               //   await Services.updateBio2(widget.wid, bio,zone, brgy, pass ).then((val){
             //     setState(() {
             //     _isLoading = false;
             //   });
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
                           //     });

                              }else{
                            //     await Services.updateBio(widget.wid, bio, filePhoto, real64, zone, brgy, pass ).then((val){
                          //        setState(() {
//_isLoading = false;
            //    });
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
                             //   });
                                
                              }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.3,
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

          ],
           
        ),
      );
                  }
                ),
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