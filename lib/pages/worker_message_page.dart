import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../styles/style.dart';
import '../helper/shared_preferences.dart';
import '../services/services.dart';
import 'package:intl/intl.dart';
import '../models/wor_chat_model.dart';
import '../screens/chat_screen.dart';



class WorkerMessagePage extends StatefulWidget {
  @override
  _WorkerMessagePageState createState() => _WorkerMessagePageState();
}

class _WorkerMessagePageState extends State<WorkerMessagePage> {
  Future<int> tem;
  int wid;
  var _isLoading = false;
   DateFormat dateFormat = DateFormat('yyyy-MM-dd - kk:mm');


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
             
              await Services.deleteWorkerChat(mid).then((val){
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

   Widget chatList(BuildContext context, WorkerChatroom customerChat) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 1,
        //horizontal: 5,
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListTile(
          onTap: () {
            String name = customerChat.fname + " " + customerChat.lname;
            int workerId = int.parse(customerChat.workerId);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ChatScreen(name, customerChat.uid, workerId, customerChat.profile,2,1),
              ),
            );
          },
          onLongPress: (){
            int id = int.parse(customerChat.chid);
             _deleteChat(id);
          },
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(customerChat.profile),
            backgroundColor: Color.fromRGBO(75, 210, 178, 1),
            child: Padding(
              padding: EdgeInsets.all(6),
            ),
          ),
          title: Row(
            children: [
              Text(customerChat.fname, style: profileName()),
              SizedBox(width: 10),
              Text(customerChat.lname, style: profileName()),
            ],
          
          ),
          subtitle: Text(dateFormat.format(DateTime.parse(customerChat.update)), style: tinyFont()),
         
        ),
      ),
    );
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
    body: RefreshIndicator(
          onRefresh: () async{
            _refreshData(wid);
          },
    child: Container(
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
            wid = worId;
            
          return FutureBuilder<List<WorkerChatroom>>(
          future: Services.getWorChat(worId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
              List<WorkerChatroom> workerChat = snapshot.data;
              if(workerChat.isEmpty){
                return  Center(
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
                itemCount: workerChat.length,
                itemBuilder: (context, int currentIndex) {
                  return chatList(context, workerChat[currentIndex]);
                },
              );
            } else if (snapshot.hasError){
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
          });
          },
    ),
    ),
    ),
    );
  }
}