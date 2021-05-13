import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

//import '../widget/worker_notification.dart';
import '../helper/shared_preferences.dart';
import '../styles/style.dart';
import '../helper/firebase_user.dart';
import '../models/wor_request_display.dart';
import '../screens/request_detail.dart';
import '../services/services.dart';


class WorkerWorkPage extends StatefulWidget {
  
  @override
  _WorkerWorkPageState createState() => _WorkerWorkPageState();
}

class _WorkerWorkPageState extends State<WorkerWorkPage> {
   Future<int> tem;
   int id;
   var _isLoading = false;
  @override
  void initState() {
     tem = SharedPrefUtils.getUser('userId');
    super.initState();
  }

  Future<void> _refreshData(int wid) async {
    setState(() {
      
    });
  
     Services.getWorkerRequest(wid);
  }
  _refresher(int wid) async {
    setState(() {
      
    });
    var data = Services.getWorkerRequest(wid);
     return data;
  }

    _deleteNotif(int mid){
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
                  message: 'Deleting ...',
                );
                await dialog.show();
             
              await Services.deleteWorkerNotif(mid).then((val){
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
            if(workerRequests.status == 'pending'){
               var route = MaterialPageRoute(
              builder: (BuildContext context) =>
                RequestDetails(value: workerRequests),
               
            );
             Navigator.of(context).push(route);
            }
            return;
          },
          onLongPress: (){
            int id = int.parse(workerRequests.jobId);
            _deleteNotif(id);
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
    return Scaffold(
      appBar: AppBar( title: Text(
          'Notifications',
      style: mediumTextStyle(),
    ),
    automaticallyImplyLeading: false,
    ),
        body: RefreshIndicator(
          onRefresh: (){
            return  _refresher(id);
          },
                  child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(170, 225, 227, 0.3),
          child: Center(
            child: FutureBuilder(
              future: tem,
              builder: (context, snapshot){
                if(snapshot.connectionState != ConnectionState.done){
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
                            final wor= snapshot.data.toString();
                            final worId = int.parse(wor);
                            UserProfile.dbUser = worId;
                            id = worId;
                           return FutureBuilder<List<WorkerRequests>>(
      future: Services.getWorkerRequest(worId),
      builder: (context, snapshot) {
           if (snapshot.hasData) {
           List<WorkerRequests> workerRequest = snapshot.data;
                if(workerRequest.isEmpty){
                   return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications,
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
                              _refreshData(worId);
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
            ),
          ),
      ),
        ),
    );
  }
}
