import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';


import '../helper/firebase_user.dart';


import '../styles/style.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String uid;
  
  ChatScreen(this.name, this.uid);
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
  DateFormat dateFormat = DateFormat('yyyy-MM-dd - kk:mm');
  var scrollController = ScrollController();
  var firebaseMessageRoot;
   DateTime _myTime;

 @override
  void initState() {
    if(UserProfile.currentUser.compareTo(widget.uid) >= 0){
      firebaseMessageRoot = UserProfile.currentUser +'-' + widget.uid;
      }else{
        firebaseMessageRoot = widget.uid + '-' + UserProfile.currentUser;
      }
    super.initState();
  }

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
                  onPressed: ()async{
                    _myTime = await NTP.now();
                  var _date = _myTime.millisecondsSinceEpoch;
                     print('My time: $_myTime');
                     print('_myTime in MILLISECONDS: $_date');
                   var timestamp = DateTime.now().millisecondsSinceEpoch;
                  // var messRef = FirebaseDatabase.instance.reference().child("message/" +  firebaseMessageRoot + "/");
                  // var newMessRef = messRef.push();
                    var messageRecord = {
                      'text': _message.text,
                      'timestamp': _date,
                      'uid': UserProfile.currentUser,

                    };
                   FirebaseDatabase.instance
                        .reference()
                   .child("message/" +  firebaseMessageRoot + "/" + _date.toString())
                        .set(messageRecord)
                        .then((value) {
                      _message.clear();
                     
                      print("message sent");
                    }).catchError((error) {
                      var errorCode = error.code;
                      var errorMessage = error.message;
                      if (errorCode == 'ERROR 17020') {
                        Fluttertoast.showToast(
                          msg: errorMessage,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.red,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: errorMessage,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.red,
                        );
                      }
                    });
                  },
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