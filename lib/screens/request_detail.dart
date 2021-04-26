import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/wor_request_display.dart';
import '../styles/style.dart';
import 'dynamic_map.dart';
import '../services/services.dart';
import '../screens/chat_screen.dart';
import '../helper/firebase_user.dart';

class RequestDetails extends StatefulWidget {
  final WorkerRequests value;
  RequestDetails({Key key, this.value}) : super(key: key);
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  var _isLoading = false;
  int userId;
  TextEditingController _reason = TextEditingController();

  @override
  void initState() {
    userId = UserProfile.dbUser;
    super.initState();
  }

  void _sendMessage(BuildContext context, String lname, String fname,
      String uid, String id, String profile) {
    String name = fname + ' ' + lname;
    int userId = int.parse(id);
    //String user = id.toString();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ChatScreen(name, uid, userId, profile, 1),
      ),
    );
  }

  _decline(BuildContext context, int jobId) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Decline Request.',
          style: TextStyle(color: Colors.black),
        ),
        content: SingleChildScrollView(
            child: ListBody(
          children: [
            TextFormField(
              validator: (value) {
                return value.isEmpty ? null : 'Please State Your Reason';
              },
              decoration: InputDecoration(hintText: 'Please enter your reason'),
              controller: _reason,
            ),
          ],
        )),
        actions: <Widget>[
          TextButton(
            child: Center(
              child: Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            onPressed: () async {
              ProgressDialog dialog = new ProgressDialog(context);
              dialog.style(
                message: 'Rejecting request...',
              );
              await dialog.show();
              var _myTime = await NTP.now();
              String updated = _myTime.toString();
              await Services.updateAcceptRequest(
                      jobId, 'rejected', 0,_reason.text, updated)
                  .then((val) {
                setState(() {
                  _isLoading = false;
                });
                dialog.hide();
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg:
                        "Success!",
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
                'Cancel',
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

  Future<void> _getCurrentUserLocation(
      BuildContext context, String location) async {
    setState(() {
      _isLoading = true;
    });
    final query = location;
    var add = await Geocoder.local.findAddressesFromQuery(query);
    var first = add.first;
    var lat = first.coordinates.latitude;
    var long = first.coordinates.longitude;
    await Location().getLocation().then((value) {
      setState(() {
        _isLoading = !_isLoading;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                DynamicMap(value.latitude, value.longitude, lat, long),
            fullscreenDialog: true,
          ));
      print(value.latitude);
      print(value.longitude);
    });
  }

  _updateStatus(int jobId) async {
    try {
      ProgressDialog dialog = new ProgressDialog(context);
      dialog.style(
        message: 'Accepting request...',
      );
      await dialog.show();
      var _myTime = await NTP.now();
      String updated = _myTime.toString();
      await Services.updateAcceptRequest(jobId, 'accepted', 0,'n/a', updated)
          .then((val) {
        setState(() {
          _isLoading = false;
        });
        dialog.hide();
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Success! Please check my work requests to see this request",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Color.fromRGBO(91, 168, 144, 1),
            textColor: Colors.white,
            fontSize: 14);
      });
    } catch (error) {
      return Fluttertoast.showToast(
          msg: "Error.Please check your internet connection.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromRGBO(91, 168, 144, 1),
          textColor: Colors.white,
          fontSize: 14);
    }
  }

  appBarWidget(BuildContext context, String loc) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.07;
    double progressBarHeight = 7;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight + progressBarHeight),
      child: AppBar(
        title: Text('Details'),
        titleSpacing: 5,
        bottom: linearProgressBar(progressBarHeight),
      ),
    );
  }

  linearProgressBar(_height) {
    if (!_isLoading) {
      return null;
    }
    return PreferredSize(
      child: SizedBox(
        width: double.infinity,
        height: _height,
        child: LinearProgressIndicator(
          backgroundColor: Colors.cyanAccent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
      preferredSize: const Size.fromHeight(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, '${widget.value.location}'),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.only(
            top: 30,
            left: 10,
            right: 10,
          ),
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 65,
                child: Container(
                  child: ListTile(
                    title:
                        Text('${widget.value.category}', style: profileName()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date: " + '${widget.value.date}',
                          style: addressStyle4(),
                        ),
                        Row(
                          children: [
                            Text("Time: ", style: addressStyle4()),
                            Text(
                              '${widget.value.startTime}',
                              style: addressStyle4(),
                            ),
                            Text(
                              '${widget.value.endTime}' == null
                                  ? "  "
                                  : " - " + '${widget.value.endTime}',
                              style: addressStyle4(),
                            ),
                          ],
                        ),
                        Text(
                          "Location: " + '${widget.value.location}',
                          style: addressStyle4(),
                        ),
                        Text(
                          "Budget: " +
                              '${widget.value.budget}' +
                              "/" +
                              '${widget.value.type}',
                          style: addressStyle4(),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Work Details: ",
                          style: addressStyle4(),
                        ),
                        Text(
                          '${widget.value.details}',
                          style: addressStyle4(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              Expanded(
                flex: 35,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                String id = userId.toString();
                                _sendMessage(
                                    context,
                                    '${widget.value.lname}',
                                    '${widget.value.fname}',
                                    '${widget.value.uid}',
                                    id,
                                    '${widget.value.profile}');
                              },
                              child: Icon(
                                Icons.messenger_outline,
                                size: MediaQuery.of(context).size.width * 0.08,
                                color: Color.fromRGBO(36, 121, 138, 1),
                              ),
                            ),
                            Text(
                              'Message',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Raleway',
                                color: const Color.fromRGBO(62, 135, 148, 1),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _getCurrentUserLocation(
                                    context, '${widget.value.location}');
                              },
                              child: Icon(
                                Icons.map,
                                size: MediaQuery.of(context).size.width * 0.08,
                                color: Color.fromRGBO(36, 121, 138, 1),
                              ),
                            ),
                            Text(
                              'View Map',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Raleway',
                                color: const Color.fromRGBO(62, 135, 148, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Container(
                            //alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                      'Work Request.',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    content: SingleChildScrollView(
                                        child: ListBody(
                                      children: [
                                        Text(
                                            'Are you sure you want to accept the request?.'),
                                      ],
                                    )),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Center(
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        onPressed: () {
                                          int id = int.parse(
                                              '${widget.value.jobId}');
                                          _updateStatus(id);
                                        },
                                      ),
                                      TextButton(
                                        child: Center(
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(62, 135, 148, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Container(
                            //alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                int id = int.parse('${widget.value.jobId}');
                                _decline(context, id);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(145, 39, 39, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Decline',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
