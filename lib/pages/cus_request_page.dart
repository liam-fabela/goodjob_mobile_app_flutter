import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widget/customer_notification.dart';
import '../helper/shared_preferences.dart';
import '../styles/style.dart';


class CustomerRequestPage extends StatefulWidget {
  @override
  _CustomerRequestPageState createState() => _CustomerRequestPageState();
}

class _CustomerRequestPageState extends State<CustomerRequestPage> {

  Future<int> tem;
  @override
  void initState() {
     tem = SharedPrefUtils.getUser('userId');
    super.initState();
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
      body: Container(
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
                          final cus= snapshot.data.toString();
                          final cusId = int.parse(cus);
                          return CustomerNotifications(cusId);
                        
            }
          ),
        ),
      ),
    );
  }
}