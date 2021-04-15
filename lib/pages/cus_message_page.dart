import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../helper/shared_preferences.dart';
import '../styles/style.dart';
import '../widget/chatrooms.dart';
import '../services/services.dart';


class CustomerMessagePage extends StatefulWidget {
  @override
  _CustomerMessagePageState createState() => _CustomerMessagePageState();
}

class _CustomerMessagePageState extends State<CustomerMessagePage> {
  Future<int> tem;
  int cid;
  // _timer;
  //StreamController _stream = StreamController();

  @override
  void initState() {
    tem = SharedPrefUtils.getUser('userId');
    _refreshData(cid);
   // _timer = Timer.periodic(Duration(seconds: 1), (timer) => _refreshData(cid));
    super.initState();
  }

  Future<void> _refreshData(int cid) async {
    
    setState(() {});
    var data =  Services.getCusChat(cid);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( title: Text(
          'Messages',
      style: mediumTextStyle(),
    ),
    automaticallyImplyLeading: false,
    ),//appBarSign(context, 'Messages'),
        body: Container(
        height: MediaQuery.of(context).size.height,
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
                          'Loading Messages',
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
            final cust = snapshot.data.toString();
            final custId = int.parse(cust);
            cid = custId;
            return ChatRooms(custId);
          },
        ),
      ),
    );
  }
}
