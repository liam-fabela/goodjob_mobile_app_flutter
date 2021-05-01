import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:intl/intl.dart';


import '../services/services.dart';
import '../styles/style.dart';
import '../models/wor_request_display.dart';
import '../screens/request_detail.dart';



class WorkerNotification extends StatefulWidget {
  final int wid;
  WorkerNotification(this.wid);
  @override
  _WorkerNotificationState createState() => _WorkerNotificationState();
}

class _WorkerNotificationState extends State<WorkerNotification> {
  formatTime(String time){
    //var format = DateFormat.jm();
    TimeOfDay _format = TimeOfDay(hour: int.parse(time.split(":")[0]),minute: int.parse(time.split(":")[1]));
    return _format;
     
  }


   Widget listWidget(BuildContext context, WorkerRequests workerRequests){
    return Card(
      elevation: 5,
       margin: EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 5,
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListTile(
          onTap: (){
            var route = MaterialPageRoute(
              builder: (BuildContext context) =>
                RequestDetails(value: workerRequests),
               
            );
             Navigator.of(context).push(route);
          },
          leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(workerRequests.profile), 
                        backgroundColor:  Color.fromRGBO(75, 210, 178, 1),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                        ),
                      ),
          title: Text(workerRequests.fname + " " +workerRequests.lname, style: addressStyle(),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              workerRequests.status == 'pending' ?  Text('has sent you a work request',)
              :  Text('has send his/her payment',),
              workerRequests.status == 'pending' ? Text(workerRequests.requested, style: extraTinyFont(),)
              : Text(workerRequests.updated, style: extraTinyFont(),),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorkerRequests>>(
      future: Services.getWorkerRequest(widget.wid),
      builder: (context, snapshot) {
         if (snapshot.hasData) {
         List<WorkerRequests> workerRequest = snapshot.data;
              if(workerRequest.isEmpty){
                 return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(height: 15),
                          Text(
                            'No notifications yet.',
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
                  itemCount: workerRequest.length,
                  itemBuilder: (context, int currentIndex) {
                    return listWidget(context, workerRequest[currentIndex]);
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
                          'Loading Notifications',
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
    );
  }
}