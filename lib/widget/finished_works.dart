import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:ntp/ntp.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/style.dart';
import '../models/wor_finished.dart';
import '../services/services.dart';

class FinishedWorksPage extends StatefulWidget {
  final int wid;
  FinishedWorksPage(this.wid);
  @override
  _FinishedWorksPageState createState() => _FinishedWorksPageState();
}

class _FinishedWorksPageState extends State<FinishedWorksPage> {
  var _isLoading = false;

  double _totalEarned(String time, String earning){
    double earn = double.parse(earning);
    double t = double.parse(time);
    double hr =  t / 3600;
    double m = earn * hr;
    return m;

  }

  _deleteWork(int id, String status) async {
    if (status != 'paid') {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Warning!',
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
              child: ListBody(
            children: [
              Text(
                  'You can\'t delete unpaid work yet.'),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: Center(
                child: Text(
                  'Okay',
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
    }else{
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
                message: 'Deleting...',
              );
              await dialog.show();
              var _myTime = await NTP.now();
              String updated = _myTime.toString();
              print(updated);
              await Services.deletWorkerWork(id, updated).then((val) {
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
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Finished Works'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: FutureBuilder<List<WorkerFinishedRequests>>(
              future: Services.getWorkerFinishedRequest(widget.wid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<WorkerFinishedRequests> workerFinished = snapshot.data;
                  if (workerFinished.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.work,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'No finished request yet.',
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
                  }
                  return ListView.builder(
                      itemCount: workerFinished.length,
                      itemBuilder: (context, int currentIndex) {
                        return Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: ListTile(
                              onLongPress: () {
                                int fid = int.parse(
                                    workerFinished[currentIndex].jobId);
                                _deleteWork(
                                    fid, workerFinished[currentIndex].status);
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                    Color.fromRGBO(75, 210, 178, 1),
                                child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(Icons.check_circle, size: 30)),
                              ),
                              title: Text(
                                  "Work Request # " +
                                      workerFinished[currentIndex].jobId,
                                  style: profileName()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Customer Name: '),
                                  Text(
                                      workerFinished[currentIndex].fname +
                                          " " +
                                          workerFinished[currentIndex].lname,
                                      style: addressStyle()),
                                  Text('Category: '),
                                  Text(workerFinished[currentIndex].category,
                                      style: addressStyle()),
                                  Text('Finished on: '),
                                  Text(workerFinished[currentIndex].updated,
                                      style: addressStyle()),
                                  Text('Earnings: '),
                                  workerFinished[currentIndex].type == 'per hour' ?
                                   Text(_totalEarned(workerFinished[currentIndex].time, workerFinished[currentIndex].budget).toStringAsFixed(2)) :
                                  Text(workerFinished[currentIndex].budget,
                                      style: addressStyle()),
                                  Text('Status: '),
                                  Text(
                                      workerFinished[currentIndex].status ==
                                              'paid'
                                          ? 'PAID'
                                          : 'UNPAID',
                                      style:
                                          workerFinished[currentIndex].status ==
                                                  'paid'
                                              ? done()
                                              : declined()),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
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
                          //_refreshData(widget.id);
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SpinKitSquareCircle(
                          color: Color.fromRGBO(62, 135, 148, 1), size: 50.0),
                    ),
                    SizedBox(height: 35),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Loading requests...',
                            style: TextStyle(
                              color: Colors.white54,
                              fontFamily: 'Raleway',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
