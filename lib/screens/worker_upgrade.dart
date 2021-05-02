import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:io';
import 'dart:convert';

import '../styles/style.dart';
import '../widget/worker_upgrade_modal.dart';
import '../models/get_worker_docu.dart';
import '../services/services.dart';

class WorkerUpgrade extends StatefulWidget {
  final int wid;
  WorkerUpgrade(this.wid);
  @override
  _WorkerUpgradeState createState() => _WorkerUpgradeState();
}

class _WorkerUpgradeState extends State<WorkerUpgrade> {
  final _formKey = GlobalKey<FormState>();
  String cat;
  File _pickedImage;
  //File _storedImage;
  String filePhoto;
  String real64;
  var _isLoading = false;

  @override
  void initState() {
    filePhoto = "";
    real64 = "";
    // TODO: implement initState
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
          child: WorkerUpgradeModal(_selectImage),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Upgrade Credibility'),
      body: FutureBuilder<List<WorkerDocu>>(
        future: Services.getWorkeDocu(widget.wid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<WorkerDocu> workerDocu = snapshot.data;
            if (workerDocu.isNotEmpty) {
              return Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: workerDocu.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _startAddPhoto(context),
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.4,
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
                                      workerDocu[index].docu,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: workerDocu[index].docType,
                                  //controller: _bio,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Document Name',
                                    hintText: 'Write your bio',
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  onSaved: (String value) {
                                    cat = value;
                                  },
                                ),
                                GestureDetector(
                                  onTap: (){},
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
