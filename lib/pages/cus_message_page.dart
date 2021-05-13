import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../models/cus_chat_model.dart';
import '../styles/style.dart';
import '../services/services.dart';
import '../screens/chat_screen.dart';
import '../helper/shared_preferences.dart';

class CustomerMessagePage extends StatefulWidget {
  @override
  _CustomerMessagePageState createState() => _CustomerMessagePageState();
}

class _CustomerMessagePageState extends State<CustomerMessagePage> {
  Future<int> tem;
  int cid;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd - kk:mm');
  var _isLoading = false;

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
    var data = Services.getCusChat(cid);
    return data;
  }

  _deleteChat(int mid){
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
                  message: 'Deleting message...',
                );
                await dialog.show();
             
              await Services.deleteCustomerChat(mid).then((val){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: mediumTextStyle(),
        ),
        automaticallyImplyLeading: false,
      ), //appBarSign(context, 'Messages'),
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
            return RefreshIndicator(
              onRefresh: () async {
                _refreshData(cid);
              },
              child: FutureBuilder<List<CustomerChatroom>>(
                  future: Services.getCusChat(cid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<CustomerChatroom> customerChat = snapshot.data;
                      if (customerChat.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inbox,
                                size: 70,
                                color: Colors.white,
                              ),
                              SizedBox(height: 15),
                              Text(
                                'No messages yet.',
                                style: TextStyle(
                                  color: Color.fromRGBO(62, 135, 148, 1),
                                  fontSize: 12,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: customerChat.length,
                        itemBuilder: (context, int currentIndex) {
                          return Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                              vertical: 1,
                              //horizontal: 5,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                onTap: () {
                                  String name =
                                      customerChat[currentIndex].fname +
                                          " " +
                                          customerChat[currentIndex].lname;
                                  int workerId = int.parse(
                                      customerChat[currentIndex].workerId);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => ChatScreen(
                                          name,
                                          customerChat[currentIndex].uid,
                                          workerId,
                                          customerChat[currentIndex].profile,
                                          2,
                                          2),
                                    ),
                                  );
                                },
                                onLongPress: (){
                                  int id = int.parse(customerChat[currentIndex].chid);
                                  _deleteChat(id);
                                },
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      customerChat[currentIndex].profile),
                                  backgroundColor:
                                      Color.fromRGBO(75, 210, 178, 1),
                                  child: Padding(
                                    padding: EdgeInsets.all(6),
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Text(customerChat[currentIndex].fname,
                                        style: profileName()),
                                    SizedBox(width: 10),
                                    Text(customerChat[currentIndex].lname,
                                        style: profileName()),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        dateFormat.format(DateTime.parse(
                                            customerChat[currentIndex].update)),
                                        style: tinyFont()),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
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
                              // _refreshData(widget.id);
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
                              color: Color.fromRGBO(62, 135, 148, 1),
                              size: 50.0),
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
                  }),
            );
          },
        ),
      ),
    );
  }
}
