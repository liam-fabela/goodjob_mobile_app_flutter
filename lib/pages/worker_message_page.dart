import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../styles/style.dart';
import '../helper/shared_preferences.dart';
//import '../styles/style.dart';
import '../services/services.dart';
//import '../models/wor_chat_model.dart';
import '../widget/work_chatroom.dart';


class WorkerMessagePage extends StatefulWidget {
  @override
  _WorkerMessagePageState createState() => _WorkerMessagePageState();
}

class _WorkerMessagePageState extends State<WorkerMessagePage> {
  Future<int> tem;
  int wid;

  @override
  void initState() {
    tem = SharedPrefUtils.getUser('userId');
    _refreshData(wid);
   // _timer = Timer.periodic(Duration(seconds: 1), (timer) => _refreshData(cid));
    super.initState();
  }

  Future<void> _refreshData(int wid) async {
    
    setState(() {});
    var data =  Services.getWorChat(wid);
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
    ),
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
            final wor = snapshot.data.toString();
            final worId = int.parse(wor);
            
            return WorkerChatroomScreen(worId);
          },
        ),
      ),
    );
  }
}
