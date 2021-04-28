import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  Widget listWidget(BuildContext context, WorkerFinishedRequests  workerFinished){
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
           leading: CircleAvatar(
                        radius: 30, 
                        backgroundColor:  Color.fromRGBO(75, 210, 178, 1),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.check_circle, size: 30)
                          
                        ),
                      ),
            title: Text("Work Request # " + workerFinished.jobId, style: profileName()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name: '),
                Text(workerFinished.fname +" " + workerFinished.lname, style: addressStyle()),
                Text('Category: '),
                Text(workerFinished.category, style: addressStyle()),
                Text('Finished on: '),
                Text(workerFinished.updated, style: addressStyle()),
                Text('Status: '),
                Text(workerFinished.status == 'paid' ? 'PAID':'UNPAID',style: workerFinished.status == 'paid' ? done()
                  : declined()
                 ),

              ],
            ),
        ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context,'Finished Works'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: FutureBuilder<List<WorkerFinishedRequests>>(
            future: Services.getWorkerFinishedRequest(widget.wid),
             builder: (context, snapshot) {
              if(snapshot.hasData) {
                List<WorkerFinishedRequests> workerFinished = snapshot.data;
                if(workerFinished.isEmpty){
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
                  itemBuilder: (context, int currentIndex){
                      return listWidget(context, workerFinished[currentIndex]);
                  }
                );
              }else if (snapshot.hasError){
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
             }
            
          ),
        ),
      ),
      
    );
  }
}