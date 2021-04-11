import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

import '../styles/style.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  
  ChatScreen(this.name);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List message =[
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    'This is a short message',
    'This is relatively longer line of text.',
    'Hi!',
  ];
  TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, widget.name),
      body: Column(
        children:[
          Expanded(
            child: ListView.builder(
              itemCount: message.length,
              itemBuilder: (context, index) {
                return Padding(padding: const EdgeInsets.all(20),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment:  
                    MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                        decoration: 
                         BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30),),
                          color: Color.fromRGBO(161, 212, 211, 1),
                        ),
                        child: Text(message[index], style: TextStyle(color: Colors.black),),
                      ),
                    ],
                ),
                );
              }

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                   child: TextFormField(
                    controller: _message,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Type your message here...',
                        border: OutlineInputBorder()),
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.send, color: Color.fromRGBO(62, 135, 148, 1),),

                ),

              ],

            ),
          ),
        ],
      ),
    );
  }
}