import 'package:flutter/material.dart';

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
  Widget chatList(BuildContext context, CustomerChatroom customerChat) {
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
            String name = customerChat.fname + " " + customerChat.lname;
            int workerId = int.parse(customerChat.workerId);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ChatScreen(name, customerChat.uid, workerId, customerChat.profile),
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CustomerChatroom>>(
        future: Services.getCusChat(widget.cid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CustomerChatroom> customerChat = snapshot.data;
            return ListView.builder(
              itemCount: customerChat.length,
              itemBuilder: (context, int currentIndex) {
                return chatList(context, customerChat[currentIndex]);
              },
            );
          }
        });
  }
}
