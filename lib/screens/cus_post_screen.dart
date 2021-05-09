import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:ntp/ntp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

import '../services/services.dart';
import '../models/display_post.dart';
import '../styles/style.dart';

class CustomerWorkPost extends StatefulWidget {
  final int cid;
  CustomerWorkPost(this.cid);
  @override
  _CustomerWorkPostState createState() => _CustomerWorkPostState();
}

class _CustomerWorkPostState extends State<CustomerWorkPost> {
 
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;
  final formKey = GlobalKey<FormState>();
  String formatted;
  final TextEditingController _time1 = TextEditingController();
  final TextEditingController _time2 = TextEditingController();
  final TextEditingController _det = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _budg = TextEditingController();

  String d;
  String time;
  String time2;
  String deets;
  String addr;
  String budget;


  var _isLoading = false;
  String formattedStartTime;
  String formattedEndTime;
  TimeOfDay t1;
  TimeOfDay t2;
 
  


  _presentTimePicker(int source) async {
    final now = DateTime.now();
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      if (source == 1) {
        setState(() {
          t1 = pickedTime;
          var time = '${t1.format(context)}';
          _time1.text = time;
        });
      }
      if (source == 2) {
        setState(() {
          t2 = pickedTime;
          var time = '${t2.format(context)}';
          _time2.text = time;
        });
      }
    });
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), //DateTime(1901, 1),
      lastDate: DateTime(2300, 1),
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

  

  _deletePost(String jid){
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Delete.',
          style: TextStyle(color: Colors.black),
        ),
        content: SingleChildScrollView(
            child: ListBody(
          children: [
            Text('Are you sure you want to delete this?'),
          ],
        )),
        actions: <Widget>[
          TextButton(
            child: Center(
              child: Text(
                'Yes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            onPressed: () async {
               ProgressDialog dialog = new ProgressDialog(context);
                dialog.style(
                  message: 'Deleting post...',
                );
                await dialog.show();
              int id = int.parse(jid);
              await Services.deleteWorkPost(id).then((val){
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
                      backgroundColor: Color.fromRGBO(91, 168, 144, 1),
                      textColor: Colors.white,
                      fontSize: 14);
                  Navigator.pop(context);
               
              });
            },
          ),
          TextButton(
            child: Center(
              child: Text(
                'No',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

  }

  _showEdit(String jid, String date, String t1, String t2, String details,
      String add, String bud) {
        _dateController.text = date;
        _time1.text = t1;
        _time2.text = t2;
        _det.text = details;
        _address.text = add;
        _budg.text = bud;
    

    Alert(
        context: context,
        title: 'Edit Post',
        content: Column(
          children: [
            Form(
                key: formKey,
              child: Column(
                children: [
                  TextField(
                    controller: _dateController,
                      decoration: inputDeco('Date:'),
                      readOnly: true,
                      onTap: _presentDatePicker,
                     ),
                  TextField(
                      controller: _time1,
                      decoration: inputDeco('Start Time:'),
                      readOnly: true,
                      onTap: () {
                        _presentTimePicker(1);
                      },
                    ),
                  TextField(
                     controller: _time2,
                      decoration: inputDeco('End Time:'),
                      readOnly: true,
                      onTap: () {
                        _presentTimePicker(2);
                      },
                      ),
                  TextField(
                      controller: _address,
                      decoration: inputDeco('Complete Address:'),
                     ),
                  TextField(
                    controller: _det,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      decoration: inputDeco('Enter Job details:'),
                      ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: _budg,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: inputDeco('Budget:'),
                            ),
                      ),
                     
                    ],
                  ),
                ],
              ),
            ),
            
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              int id = int.parse(jid);
              if (formKey.currentState.validate()) {
                ProgressDialog dialog = new ProgressDialog(context);
                dialog.style(
                  message: 'Updating post...',
                );
                await dialog.show();
                 
                await Services.updateWorkPost(
                        id,formatted, _time1.text, _time2.text, _det.text, _address.text, _budg.text)
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
                      backgroundColor: Color.fromRGBO(91, 168, 144, 1),
                      textColor: Colors.white,
                      fontSize: 14);
                });
              }
            },
            color: Color.fromRGBO(62, 135, 148, 1),
            child: Text("Update",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ]).show();
  }

  Widget postWidget(BuildContext context, DisplayPost displayPost) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 5,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.only(top: 15, left: 10, right: 2),
        child: Column(
          children: [
            Expanded(
              flex: 85,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(displayPost.profile),
                  backgroundColor: Color.fromRGBO(75, 210, 178, 1),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(displayPost.fname + " " + displayPost.lname,
                        style: profileName()),
                    PopupMenuButton(
                      onSelected: (int selectedValue) {
                        print(selectedValue);
                        if (selectedValue == 0) {
                          _showEdit(
                              displayPost.workPostId,
                              displayPost.date,
                              displayPost.startTime,
                              displayPost.endTime,
                              displayPost.location,
                              displayPost.details,
                              displayPost.budget
                             );
                        }else{
                          _deletePost(displayPost.workPostId);
                        }
                      },
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (_) => [
                        PopupMenuItem(
                            child: Text('Edit', style: addressStyle()),
                            value: 0),
                        PopupMenuItem(
                            child: Text('Delete', style: addressStyle()),
                            value: 1),
                      ],
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Category: " + displayPost.catType,
                        style: addressStyle()),
                    Text("What: " + displayPost.details, style: addressStyle()),
                    Text("Where: " + displayPost.location,
                        style: addressStyle()),
                    Text("When: " + displayPost.date, style: addressStyle()),
                    Row(
                      children: [
                        Text(displayPost.startTime, style: addressStyle()),
                        Text(
                          displayPost.endTime == null
                              ? " "
                              : " - " + displayPost.endTime,
                          style: addressStyle(),
                        ),
                      ],
                    ),
                    Text(
                        "Budget: " + displayPost.budget == null
                            ? "Not specified"
                            : displayPost.budget + "/" + displayPost.type,
                        style: addressStyle()),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(displayPost.createdOn, style: extraTinyFont()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'My Work Posts'),
      body: FutureBuilder<List<DisplayPost>>(
          future: Services.getPost2(widget.cid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DisplayPost> displayPost = snapshot.data;
              if (displayPost.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Icon(Icons.wysiwyg_rounded,
                            size: 50, color: Colors.white)),
                    SizedBox(height: 10),
                    Center(
                      child: Text('No work posts yet', style: addressStyle()),
                    ),
                  ],
                );
              } else {
                List<DisplayPost> displayPost = snapshot.data;
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: displayPost.length,
                    itemBuilder: (context, int index) {
                      if (displayPost[index].workPostId == null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wysiwyg_rounded,
                                size: 50, color: Colors.white),
                            SizedBox(height: 10),
                            Text('No work posts yet', style: addressStyle()),
                          ],
                        );
                      }
                      return postWidget(context, displayPost[index]);
                    },
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.wifi_off_outlined,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Connection error.',
                      style: TextStyle(
                        color: Color.fromRGBO(62, 135, 148, 1),
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
                  )
                ],
              );
            }
            return loadingScreen(context, 'Loading work posts');
          }),
    );
  }
}
