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
  String _choice2;
  var _perHour = false;
  var _perWork = false;
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;
  final formKey = GlobalKey<FormState>();
  String formatted;
  final TextEditingController _time1 = TextEditingController();
  final TextEditingController _time2 = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _details = TextEditingController();
  final TextEditingController _budget = TextEditingController();
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

  void _getBudget(bool state, String option) {
    if (state && option == 'hour') {
      _choice2 = 'per Hour';
    } else if (state && option == 'work') {
      _choice2 = 'per Work';
    } else {
      _choice2 = null;
    }
  }





  _showEdit(String date, String t1, String t2, String details, String add,String bud, String type){
    Alert(
      context: context,
        title: 'Edit Post',
        content: Column(
          children: [
            Form(
              child: Column(children: [
                 TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Choose a Date' : null;
                          },
                         initialValue: date,
                          decoration: inputDeco('Date:'),
                          readOnly: true,
                          onTap: _presentDatePicker,
                        ),
                  TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Choose a Time' : null;
                          },
                          initialValue: t1,
                          decoration: inputDeco('Start Time:'),
                          readOnly: true,
                          onTap: () {
                            _presentTimePicker(1);
                          },
                        ),
                        TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Choose a Time' : null;
                          },
                          initialValue: t2,
                          decoration: inputDeco('End Time:'),
                          readOnly: true,
                          onTap: () {
                            _presentTimePicker(2);
                          },
                        ),
                         TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Enter Address' : null;
                          },
                          initialValue: add,
                          decoration: inputDeco('Complete Address:'),
                        ),
                        TextFormField(
                          validator: (val) {
                            return val.isEmpty ? 'Please Enter Details' : null;
                          },
                          initialValue: details,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: inputDeco('*Enter Job details:'),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (val) {
                                  return val.isEmpty
                                      ? 'Please Enter Budget'
                                      : null;
                                },
                                 initialValue: bud,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: inputDeco('Budget:'),
                              ),
                            ),
                            Text(
                              'per',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: 'Raleway'),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Wrap(
                                spacing: 2,
                                // runSpacing: 2,
                                children: [
                                  ChoiceChip(
                                    label: Text('hour', style: addressStyle3()),
                                    selected: _perHour,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(62, 135, 140, 0.5),
                                    onSelected: !_perWork
                                        ? (val) {
                                            setState(() {
                                              _perHour = !_perHour;
                                              _getBudget(_perHour, 'hour');
                                            });
                                          }
                                        : null,
                                    selectedColor:
                                        Color.fromRGBO(62, 135, 148, 1),
                                  ),
                                  ChoiceChip(
                                    label: Text('work', style: addressStyle3()),
                                    selected: _perWork,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(62, 135, 140, 0.5),
                                    onSelected: !_perHour
                                        ? (val) {
                                            setState(() {
                                              _perWork = !_perWork;
                                              _getBudget(_perWork, 'work');
                                            });
                                          }
                                        : null,
                                    selectedColor:
                                        Color.fromRGBO(62, 135, 148, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
              ],),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              if (formKey.currentState.validate()) {
                
               
                ProgressDialog dialog = new ProgressDialog(context);
                dialog.style(
                  message: 'Sending Review...',
                );
                await dialog.show();
                
              }
            },
            color: Color.fromRGBO(62, 135, 148, 1),
            child: Text("Update",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ]
    ).show();
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
             child:
            ListTile(
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
                    onSelected: (int selectedValue){
                      print(selectedValue);
                        if(selectedValue ==0){
                           _showEdit(displayPost.date,displayPost.startTime, displayPost.endTime, displayPost.location,
                           displayPost.details, displayPost.budget, displayPost.type);
                        }
                       
                    },
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (_) =>
                      [
                      PopupMenuItem(child: Text('Edit', style: addressStyle()), value: 0),
                      PopupMenuItem(child: Text('Delete', style: addressStyle()), value: 1),
                      ],
                  
                  ),
                ],
              ),
              subtitle:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Category: " + displayPost.catType, style: addressStyle()),
                    Text("What: " + displayPost.details, style: addressStyle()),
                    Text("Where: " + displayPost.location, style: addressStyle()),
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
                                  Center(child: Icon(Icons.wysiwyg_rounded, size: 50, color: Colors.white)),
                                  SizedBox(height: 10),
                                  Center(
                                    child: Text('No work posts yet',
                                        style: addressStyle()),
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
                                    if(displayPost[index].workPostId== null){
                                       return Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wysiwyg_rounded, size: 50, color: Colors.white),
                                  SizedBox(height: 10),
                                  Text('No work posts yet',
                                      style: addressStyle()),
                                ],
                              );
                                    }
                                    return postWidget(context, displayPost[index]);
                                  },
                                ),
                              );
                          }
                        }else if (snapshot.hasError) {
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
                                )
                              ],
                            );
                          }
                         return loadingScreen(context,'Loading work posts');
                        }
                   
                        
        ),
     
    );
  }
}