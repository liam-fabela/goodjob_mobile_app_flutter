import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../services/services.dart';
import '../styles/style.dart';
import '../models/cus_notification.dart';
import '../screens/worker_profile_details.dart';

class CustomerPostNotification extends StatefulWidget {
  final int cid;
  CustomerPostNotification(this.cid);

  @override
  _CustomerPostNotificationState createState() => _CustomerPostNotificationState();
}

class _CustomerPostNotificationState extends State<CustomerPostNotification> {
   DateFormat dateFormat = DateFormat('yyyy-MM-dd - kk:mm');
    var _isLoading = false;

   _deletePost(int wid, int pin){
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
                  message: 'Deleting notification...',
                );
            await dialog.show();
              await Services.deletePostNotif(wid,pin).then((val){
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
   Widget listWidget(BuildContext context, CustomerNotification customerNotification){
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
        //      var route = MaterialPageRoute(
        //        builder: (BuildContext context) => PaymentUi(value: customerRequests),

        //      );
        //      Navigator.of(context).push(route);
               Navigator.pushNamed(context, ProfileDetails.routeName,
         arguments:{
           'id': customerNotification.wid,
           'category': customerNotification.catType,
           'catId': customerNotification.catId,
           }
         );
          },
          onLongPress: (){
            int wid = int.parse(customerNotification.wid);
            int pin = int.parse(customerNotification.pid);

            _deletePost(wid, pin);
          },
         leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(customerNotification.profile), 
                        backgroundColor:  Color.fromRGBO(75, 210, 178, 1),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                        ),
                      ),
          title: Text(customerNotification.fname + " " +customerNotification.lname, style: profileName(),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("has responded to your " + customerNotification.catType + " work post, tap to see worker profile", style: addressStyle(),
              ),
              Text(dateFormat.format(DateTime.parse(customerNotification.sent)), style: extraTinyFont(),),
              
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CustomerNotification>>(
      future: Services.getCusNotif(widget.cid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
           List<CustomerNotification> customerNotification = snapshot.data;
              if(customerNotification.isEmpty){
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
                itemCount: customerNotification.length,
                itemBuilder: (context, int currentIndex) {
                    return listWidget(context, customerNotification[currentIndex]);
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