import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../services/services.dart';
import '../models/customer_request_display.dart';
import '../styles/style.dart';
//import 'cus_decline_message.dart';
import '../screens/payment_ui.dart';

class CustomerNotifications extends StatefulWidget {
  final int cid;
  CustomerNotifications(this.cid);
  @override
  _CustomerNotificationsState createState() => _CustomerNotificationsState();
}

class _CustomerNotificationsState extends State<CustomerNotifications> {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd - kk:mm');
  formatTime(String time) {
    //var format = DateFormat.jm();
    TimeOfDay _format = TimeOfDay(
        hour: int.parse(time.split(":")[0]),
        minute: int.parse(time.split(":")[1]));
    return _format;
  }

  _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Message from Worker.',
          style: TextStyle(color: Colors.black),
        ),
        content: SingleChildScrollView(
            child: ListBody(
          children: [
            Text(message),
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
  }

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
          onTap: () {
            if (customerRequests.status == 'done') {
              var route = MaterialPageRoute(
                builder: (BuildContext context) =>
                    PaymentUi(value: customerRequests),
              );
              Navigator.of(context).push(route);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentUi(customerRequests)),);
            } else if (customerRequests.status == 'declined') {
              _showMessage(context, customerRequests.reason);
            } else {
              return;
            }
          },
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(customerRequests.profile),
            backgroundColor: Color.fromRGBO(75, 210, 178, 1),
            child: Padding(
              padding: EdgeInsets.all(6),
            ),
          ),
          title: Text(
            customerRequests.fname + " " + customerRequests.lname,
            style: profileName(),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customerRequests.status == 'accepted'
                    ? 'has accepted your work request'
                    : customerRequests.status == 'done'
                        ? 'has finished his/her work, tap to continue to payment'
                        : 'has declined your request, click for more details',
                style: addressStyle(),
              ),
              Text(
                dateFormat.format(DateTime.parse(customerRequests.updated)),
                style: extraTinyFont(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CustomerRequests>>(
        future: Services.getCustomerRequest(widget.cid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CustomerRequests> customerRequest = snapshot.data;
            if (customerRequest.isEmpty) {
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
                itemCount: customerRequest.length,
                itemBuilder: (context, int currentIndex) {
                  return listWidget(context, customerRequest[currentIndex]);
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
        });
  }
}
