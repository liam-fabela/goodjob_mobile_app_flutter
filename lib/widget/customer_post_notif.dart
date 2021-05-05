import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

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


   Widget listWidget(BuildContext context, CustomerNotification customerNotification){
    return Card(
      elevation: 5,
       margin: EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 5,
      ),
      child: Container(
        padding: EdgeInsets.only(top: 10),
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
           'uid': customerNotification.uid,
           'catId': customerNotification.catId,
           }
         );
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