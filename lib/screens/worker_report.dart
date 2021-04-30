import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ntp/ntp.dart';
import 'package:progress_dialog/progress_dialog.dart';


import '../styles/style.dart';
import '../services/services.dart';

class WorkerReport extends StatefulWidget {
  final int wid;
  WorkerReport(this.wid);
  @override
  _WorkerReportState createState() => _WorkerReportState();
}

class _WorkerReportState extends State<WorkerReport> {
  TextEditingController report = TextEditingController();
  var _isLoading = false;


  _sentComplaint(BuildContext context, int id, String com)async{
    ProgressDialog dialog = new ProgressDialog(context);
              dialog.style(
                message: 'Sending complaints...',
              );
              await dialog.show();
              var _myTime = await NTP.now();
              String updated = _myTime.toString();
    await Services.insertComplaints(id, com, updated).then((val){
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context,'Write a report'),
      body: Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: report,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '',
              ),
            maxLines: 5,
            ),
            SizedBox(height: 25),
             GestureDetector(
                              onTap: ()async{
                               _sentComplaint(context,widget.wid, report.text);
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
                                  'Send',
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
      ),
    );
  }
}