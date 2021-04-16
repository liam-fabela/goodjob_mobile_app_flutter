import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../models/cus_chat_model.dart';
import '../styles/style.dart';
import '../services/services.dart';
import '../screens/chat_screen.dart';

class ChatRooms extends StatefulWidget {
  final int cid;
  ChatRooms(this.cid);
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd - kk:mm');

   void initState() {
   _refreshData(widget.cid);
    super.initState();
  }

  Future<void> _refreshData(int cid) async {
    var data = await Services.getCusChat(cid);
    setState(() {
      return data;
    });
    
    
  }

  

  Widget chatList(BuildContext context, CustomerChatroom customerChat) {
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
          trailing: Text(dateFormat.format(DateTime.parse(customerChat.update)), style: tinyFont()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
          onRefresh: () async{
            _refreshData(widget.cid);
          },
          child: FutureBuilder<List<CustomerChatroom>>(
          future: Services.getCusChat(widget.cid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
              List<CustomerChatroom> customerChat = snapshot.data;
              if(customerChat.isEmpty){
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
                itemCount: customerChat.length,
                itemBuilder: (context, int currentIndex) {
                  return chatList(context, customerChat[currentIndex]);
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
