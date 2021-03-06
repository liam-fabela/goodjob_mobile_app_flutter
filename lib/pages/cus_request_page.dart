import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widget/customer_notification.dart';
import '../helper/shared_preferences.dart';
import '../styles/style.dart';
import '../screens/customer_notifs_tab.dart';
import '../widget/notif_work_post.dart';
import '../widget/notif_work_request.dart';

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
      return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Notifications',
                      style: mediumTextStyle(),
                    ),
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          text: 'Work Requests',
                        ),
                        Tab(text: 'Work Posts'),
                      ],
                    ),
                  ),
                  body: Container(
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(170, 225, 227, 0.3),
      child: Center(
        child: FutureBuilder(
            future: tem,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
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
              final cus = snapshot.data.toString();
              final cusId = int.parse(cus);
              final List<Widget> pages = [
                WorkRequestContainer(cusId),
                WorkPostContainer(cusId),
              ];
                return TabBarView(
                    children: pages,
                  );
            },
                ),
      ),
              ),
          ),
      );
  
  }
}
