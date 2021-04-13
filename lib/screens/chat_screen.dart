import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../helper/firebase_user.dart';
import '../services/services.dart';
import '../helper/shared_preferences.dart';

import '../styles/style.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String uid;
  final int receiverId;
  final String profile;

  ChatScreen(this.name, this.uid, this.receiverId, this.profile);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List message = [
    // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    // 'This is a short message',
    // 'This is relatively longer line of text.',
    // 'Hi!',
  ];
  TextEditingController _message = TextEditingController();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd - kk:mm');
  var scrollController = ScrollController();
  var firebaseMessageRoot;
  DateTime _myTime;
  var _isLoading = false;

  @override
  void initState() {
    if (UserProfile.currentUser.compareTo(widget.uid) >= 0) {
      firebaseMessageRoot = UserProfile.currentUser + '-' + widget.uid;
      _createChat();
    } else {
      firebaseMessageRoot = widget.uid + '-' + UserProfile.currentUser;
      _createChat();
    }
    FirebaseDatabase.instance
        .reference()
        .child("message/" + firebaseMessageRoot)
        .onChildAdded
        .listen((event) {
      _refreshMessage();
    });
    super.initState();
  }

  _createChat() async {
    var sender = await SharedPrefUtils.getUser('userId');
    String s = sender.toString();
    int sen = int.parse(s);
    Services.createChat(sen, widget.receiverId, firebaseMessageRoot)
        .then((value) {
      print('chatroom created');
    });
  }

  void _refreshMessage() {
    setState(() {
      _isLoading = true;
    });
    FirebaseDatabase.instance
        .reference()
        .child("message/" + firebaseMessageRoot)
        .once()
        .then((datasnapshot) {
      setState(() {
        _isLoading = false;
      });
      var _tempList = [];

      datasnapshot.value.forEach((key, value) {
        //value['image'] =
        //    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRmnjDhMCngFmr4rEC9mehmrjgCbo2tQX-Cg&usqp=CAU';
        value['currentUser'] = UserProfile.currentUser;

        _tempList.add(value);
      });
      _tempList.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
//      _tempList.sort((b, a) {
//        return b["timestamp"].compareTo(a["timestamp"]);
//      });

//      print(datasnapshot.value);

      if (mounted) {
        setState(() {
          message = _tempList;
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }
    }).catchError((error) {
      var errorCode = error.code;
      var errorMessage = error.message;
      if (errorCode == 'ERROR 17020') {
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.grey,
          textColor: Colors.red,
        );
      } else {
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.grey,
          textColor: Colors.red,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, widget.name),
      body: _isLoading
          ? Column(
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
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: message.length,
                      itemBuilder: (context, index) {
                        return message.length == 0
                            ? Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.inbox_outlined,
                                          size: 50, color: Colors.white54),
                                      Text(
                                        'No messages yet',
                                        style: mediumTextStyle(),
                                      ),
                                    ]),
                              )
                            : message[index]['uid'] ==
                                    message[index]['currentUser']
                                ? Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: 
                                        Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(20),
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.7),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                                color: Color.fromRGBO(
                                                    161, 212, 211, 1),
                                              ),
                                              child: Text(
                                                  message[index]['text'],
                                                  style: reviewStyle()),
                                            ),
                                          ],
                                        ),
                                     
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage:
                                              NetworkImage(widget.profile),
                                          backgroundColor:
                                              Color.fromRGBO(75, 210, 178, 1),
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                          ),
                                        ),
                                        Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(20),
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.7),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                                color: Color.fromRGBO(
                                                    161, 212, 211, 1),
                                              ),
                                              child: Text(
                                                  message[index]['text'],
                                                  style: reviewStyle()),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                      }),
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
                        onPressed: () async {
                          _myTime = await NTP.now();
                          var _date = _myTime.millisecondsSinceEpoch;
                          print('My time: $_myTime');
                          print('_myTime in MILLISECONDS: $_date');
                          //var timestamp = DateTime.now().millisecondsSinceEpoch;
                          // var messRef = FirebaseDatabase.instance.reference().child("message/" +  firebaseMessageRoot + "/");
                          // var newMessRef = messRef.push();
                          var messageRecord = {
                            'text': _message.text,
                            'timestamp': _date,
                            'uid': UserProfile.currentUser,
                          };
                          FirebaseDatabase.instance
                              .reference()
                              .child("message/" +
                                  firebaseMessageRoot +
                                  "/" +
                                  _date.toString())
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
                        icon: Icon(
                          Icons.send,
                          color: Color.fromRGBO(62, 135, 148, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
