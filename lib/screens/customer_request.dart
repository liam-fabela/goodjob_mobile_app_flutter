import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

import '../styles/style.dart';
import '../models/customer_request_display.dart';
import '../services/services.dart';

class CustomerRequest extends StatefulWidget {
  final int custId;
  CustomerRequest(this.custId);
  @override
  _CustomerRequestState createState() => _CustomerRequestState();
}

class _CustomerRequestState extends State<CustomerRequest> {
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

  formatTime(String time) {
    //var format = DateFormat.jm();
    TimeOfDay _format = TimeOfDay(
        hour: int.parse(time.split(":")[0]),
        minute: int.parse(time.split(":")[1]));
    return _format;
  }

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

  _deletePost(String jid) {
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
              await Services.deleteWorkRequest(id).then((val) {
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
                if(formatted == null){
                   ProgressDialog dialog = new ProgressDialog(context);
                dialog.style(
                  message: 'Updating post...',
                );
                await dialog.show();

                await Services.updateWorkRequest(id, date, _time1.text,
                        _time2.text, _det.text, _address.text, _budg.text)
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
                ProgressDialog dialog = new ProgressDialog(context);
                dialog.style(
                  message: 'Updating post...',
                );
                await dialog.show();

                await Services.updateWorkRequest(id, formatted, _time1.text,
                        _time2.text, _det.text, _address.text, _budg.text)
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

  DateFormat formatter = DateFormat('yyyy-MM-dd');
  Widget listWidget(BuildContext context, CustomerRequests customerRequests) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 5,
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Color.fromRGBO(75, 210, 178, 1),
            child: Padding(
                padding: EdgeInsets.all(6),
                child: customerRequests.status == 'pending'
                    ? Icon(Icons.hourglass_top_rounded, size: 30)
                    : customerRequests.status == 'accepted'
                        ? Icon(Icons.check_circle_outline_outlined, size: 30)
                        : customerRequests.status == 'done'
                            ? Icon(Icons.check_circle, size: 30)
                            : customerRequests.status == 'paid'
                                ? Icon(Icons.credit_card, size: 30)
                                : Icon(Icons.cancel_outlined, size: 30)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Request ID " + customerRequests.jobId,
                style: profileName(),
              ),
              PopupMenuButton(
                onSelected: (int selectedValue) {
                  print(selectedValue);
                  print(customerRequests.location);
                  print(customerRequests.details);
                  print(customerRequests.budget);
                  if (selectedValue == 0) {
                    _showEdit(
                        customerRequests.jobId,
                        customerRequests.date,
                        customerRequests.startTime,
                        customerRequests.endTime,
                        customerRequests.location,
                        customerRequests.details,
                        customerRequests.budget);
                  } else {
                    _deletePost(customerRequests.jobId);
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (_) => [
                  PopupMenuItem(
                      child: Text('Edit', style: addressStyle()), value: 0),
                  PopupMenuItem(
                      child: Text('Delete', style: addressStyle()), value: 1),
                ],
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customerRequests.fname + " " + customerRequests.lname,
                style: addressStyle(),
              ),
              SizedBox(height: 5),
              Text(customerRequests.category, style: addressStyle()),
              SizedBox(height: 5),
              Text(
                '${DateFormat.yMd().format(DateTime.parse(customerRequests.date))}',
                style: addressStyle(),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    customerRequests.startTime,
                    style: addressStyle(),
                  ),
                  Text(customerRequests.endTime == null ? '' : '-'),
                  Text(
                    customerRequests.endTime == null
                        ? ''
                        : customerRequests.endTime,
                    style: addressStyle(),
                  ),
                ],
              ),
              Text(
                "Address: " + customerRequests.location,
                style: addressStyle(),
              ),
              Text(
                "Details: " + customerRequests.details,
                style: addressStyle(),
              ),
              Text(
                "Status: " + customerRequests.status,
                style: customerRequests.status == 'pending'
                    ? pending()
                    : customerRequests.status == 'accepted'
                        ? accepted()
                        : customerRequests.status == 'done'
                            ? done()
                            : customerRequests.status == 'paid'
                                ? paid()
                                : declined(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'My Requests'),
      body: Center(
        child: FutureBuilder<List<CustomerRequests>>(
          future: Services.getAllCustomerRequest(widget.custId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CustomerRequests> customerRequests = snapshot.data;
              if (customerRequests.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.article_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'No request made.',
                      style: TextStyle(
                        color: Color.fromRGBO(62, 135, 148, 1),
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: customerRequests.length,
                    itemBuilder: (context, int currentIndex) {
                      return listWidget(
                        context,
                        customerRequests[currentIndex],
                      );
                    });
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
            return loadingScreen(context, 'Loading...');
          },
        ),
      ),
    );
  }
}
