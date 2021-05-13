import 'package:flutter/material.dart';
import 'dart:async';
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/style.dart';
import '../services/services.dart';
//import '../models/wor_accepted.dart';

class WorkerTimer extends StatefulWidget {
  // final WorkerAcceptedRequests value;
  // WorkerTimer({Key key, this.value}) : super(key: key);

  final int jobId;
  WorkerTimer(this.jobId);

  @override
  _WorkerTimerState createState() => _WorkerTimerState();
}

class _WorkerTimerState extends State<WorkerTimer> {
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer timer;
  var _isLoading = false;

  void handleTick() {
    if (!mounted) {
      return;
    }
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  _updateStatus(int jobId, int time) async {
    try {
      ProgressDialog dialog = new ProgressDialog(context);
      dialog.style(
        message: 'Updating work status...',
      );
      await dialog.show();

      var _myTime = await NTP.now();
      String updated = _myTime.toString();
      await Services.updateAcceptRequest(jobId, 'done', time, 'n/a', updated)
          .then((val) {
        setState(() {
          _isLoading = false;
        });
        dialog.hide();
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Success! Customer is notified of your work",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Color.fromRGBO(91, 168, 144, 1),
            textColor: Colors.white,
            fontSize: 14);
      });
    } catch (error) {
      return Fluttertoast.showToast(
          msg: "Error.Please check your internet connection.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromRGBO(91, 168, 144, 1),
          textColor: Colors.white,
          fontSize: 14);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return Scaffold(
      appBar: appBarSign(context, 'Timer'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LabelText(
                    label: 'HRS', value: hours.toString().padLeft(2, '0')),
                LabelText(
                  label: 'MIN',
                  value: minutes.toString().padLeft(2, '0'),
                ),
                LabelText(
                  label: 'SEC',
                  value: seconds.toString().padLeft(2, '0'),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.1,
                  margin: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                      color: Color.fromRGBO(61, 143, 135, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(isActive ? 'STOP' : 'START',
                          style: buttonName()),
                      onPressed: () {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          isActive = !isActive;
                        });
                      }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.1,
                  margin: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                      color: Color.fromRGBO(61, 143, 135, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Text('RESTART', style: buttonName()),
                      onPressed: () {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          isActive = false;
                          secondsPassed = 0;
                        });
                      }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.1,
                  margin: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                      color: Color.fromRGBO(61, 143, 135, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Text('SAVE', style: buttonName()),
                      onPressed: () {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          isActive = false;
                        });
                          showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Save time', style: TextStyle(color: Colors.black),),
                content: SingleChildScrollView(child:ListBody(children: [
                   Text('Are you sure you want to submit work time?.'),
                ],)),
                actions: <Widget>[
                 
                  TextButton(
                    child: Center(child: Text('Yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
                    onPressed: () {
                        _updateStatus(widget.jobId, secondsPassed);
                        print(secondsPassed);
                      
                    },
                  ),
                   TextButton(
                    child: Center(child: Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
                    onPressed: () {
                       Navigator.of(context).pop();
                    },
                  ),
                ],
          ),
         );
                       
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.teal,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
