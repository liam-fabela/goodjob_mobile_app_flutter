import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../models/wor_chat_model.dart';
import '../styles/style.dart';
import '../services/services.dart';
import '../screens/chat_screen.dart';


class WorkerChatroomScreen extends StatefulWidget {
   final int wid;
  WorkerChatroomScreen(this.wid);
  @override
  _WorkerChatroomScreenState createState() => _WorkerChatroomScreenState();
}

class _WorkerChatroomScreenState extends State<WorkerChatroomScreen> {
   DateFormat dateFormat = DateFormat('yyyy-MM-dd - kk:mm');

   void initState() {
   _refreshData(widget.wid);
    super.initState();
  }

  Future<void> _refreshData(int wid) async {
    var data = await Services.getWorChat(wid);
    setState(() {
      return data;
    });
    
    
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
                builder: (ctx) => ChatScreen(name, customerChat.uid, workerId, customerChat.profile,2),
              ),
            );
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
          trailing: Text("Button here"),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
      return RefreshIndicator(
          onRefresh: () async{
            _refreshData(widget.wid);
          },
          child: FutureBuilder<List<WorkerChatroom>>(
          future: Services.getWorChat(widget.wid),
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
          }),
    );
  }
}