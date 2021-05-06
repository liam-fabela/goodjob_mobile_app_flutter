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

  _deleteWork(int id) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
      message: 'Deleting...',
    );
    await dialog.show();
    var _myTime = await NTP.now();
    String updated = _myTime.toString();
    print(updated);
    await Services.deletWorkerWork(id, updated).then((val){
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
                         //List<WorkerFinishedRequests> workerFinished = snapshot.data;
                        return Dismissible(
      key: ValueKey(workerFinished[currentIndex]),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to delete work info?',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
       
        //workerFinished[currentIndex].
       
        int id = int.parse(workerFinished[currentIndex].jobId);
         _deleteWork(id).then((val){
           setState((){

           });
            snapshot.data.removeAt(currentIndex);
         });
        
        
        
      },
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Color.fromRGBO(75, 210, 178, 1),
              child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.check_circle, size: 30)),
            ),
            title: Text("Work Request # " + workerFinished[currentIndex].jobId,
                style: profileName()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name: '),
                Text(workerFinished[currentIndex].fname + " " + workerFinished[currentIndex].lname,
                    style: addressStyle()),
                Text('Category: '),
                Text(workerFinished[currentIndex].category, style: addressStyle()),
                Text('Finished on: '),
                Text(workerFinished[currentIndex].updated, style: addressStyle()),
                 Text('Earnings: '),
                Text(workerFinished[currentIndex].budget, style: addressStyle()),
                Text('Status: '),
                Text(workerFinished[currentIndex].status == 'paid' ? 'PAID' : 'UNPAID',
                    style:
                        workerFinished[currentIndex].status == 'paid' ? done() : declined()),
              ],
            ),
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
