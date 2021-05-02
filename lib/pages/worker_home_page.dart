import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ntp/ntp.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/display_post.dart';
import '../styles/style.dart';
import '../helper/firebase_user.dart';
import '../helper/shared_preferences.dart';
import '../services/services.dart';
import '../models/worker_earning.dart';

class WorkerHomePage extends StatefulWidget {
  @override
  _WorkerHomePageState createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  static const url = 'https://goodjob-mobile-app.000webhostapp.com/check_application.php';
  bool _isLoading;
  int wid;
   Future<int> tem;
  @override
  void initState() {
    tem = SharedPrefUtils.getUser('userId');
    print("TEM :" + tem.toString());
    _getData();
    _getWortId();
    super.initState();
  }

  _getData() {
    var user = FirebaseAuth.instance.currentUser.uid;
    UserProfile.currentUser = user;
    print('LOGGED IN USER $user');
  }

  _getWortId() async {
    var id = await SharedPrefUtils.getUser('userId');
    String cus = id.toString();
    wid = int.parse(cus);
  }

Future<String> _checkApp(BuildContext context,int wid)async{
     try {
        setState(() {
          _isLoading = true;
        });
        print("gisulod dne");
        var map = Map<String, dynamic>();
        map["wid"] = wid;

        http.Response response = await http.post(url,
            body: jsonEncode(map),
            headers: {'Content-type': 'application/json'});
        print('Login Response: ${response.body}');

        if (200 == response.statusCode) {
          print(response.body);
          var data = json.decode(response.body);
          if(data["status"] == 'Success!'){
           return data["status"];
            //('ok');
          }else{
           
              return data["status"];
          }
        }
         
      } catch (e) {
        print(e);
        throw (e);
      }
    } 


  _notifyCustomer(BuildContext context , int id, int cid, int wid) async{
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Send Notification.',
          style: TextStyle(color: Colors.black),
        ),
        content: Text('Notify customer that you want to do the job?'),
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
                message: 'Sending notification...',
              );
              await dialog.show();
              var _myTime = await NTP.now();
              String updated = _myTime.toString();
             _checkApp(context,wid).then((val){
               if(val.toString() == 'ok'){
                 Services.insertNotif(id,cid, wid, updated).then((val){

                setState(() {
                  _isLoading = false;
                });
                 dialog.hide();
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg:
                       'Success!',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Color.fromRGBO(91, 168, 144, 1),
                    textColor: Colors.white,
                    fontSize: 14);

            
               
             });
               }else{
                 setState(() {
                  _isLoading = false;
                });
                 dialog.hide();
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg:
                       'You already applied!',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Color.fromRGBO(91, 168, 144, 1),
                    textColor: Colors.white,
                    fontSize: 14);
               }
                
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

  Widget postWidget(BuildContext context, DisplayPost displayPost) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 5,
      ),
     
      child: Container(
         height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(displayPost.profile),
                backgroundColor: Color.fromRGBO(75, 210, 178, 1),
                child: Padding(
                  padding: EdgeInsets.all(6),
                ),
              ),
              title: Text(displayPost.fname + " " + displayPost.lname,
                  style: profileName()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Category: " + displayPost.catType, style: addressStyle()),
                  Text("What: " + displayPost.details, style: addressStyle()),
                  Text("Where: " + displayPost.location, style: addressStyle()),
                  Text("When: " + displayPost.date, style: addressStyle()),
                  Row(
                    children: [
                      Text(displayPost.startTime, style: addressStyle()),
                      Text(
                        displayPost.endTime == null
                            ? " "
                            : " - " + displayPost.endTime,
                        style: addressStyle(),
                      ),
                    ],
                  ),
                  Text(
                      "Budget: " + displayPost.budget == null
                          ? "Not specified"
                          : displayPost.budget + "/" + displayPost.type,
                      style: addressStyle()),
                ],
                
              ),
             
            ),
            SizedBox(height: 20),
             GestureDetector(
                              onTap: ()async{
                                int id = int.parse(displayPost.workPostId);
                                print("FROM ON TAP" +id.toString());
                                int cid = int.parse(displayPost.customerId);
                                _notifyCustomer(context, id,cid, wid);
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
                                  'Apply',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
          ],
        ),
         
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 50,
            child: Center(
              child: Card(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.03,
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Color.fromRGBO(111, 209, 204, 1),
                  ),
                  child: FutureBuilder(
                    future: tem,
                      builder: (context, snapshot){
                        if(snapshot.connectionState != ConnectionState.done){
                           return Center(
                            child: SpinKitSquareCircle(
                                color: Color.fromRGBO(62, 135, 148, 1),
                                size: 50.0),
                          );
                        }
                        final cust = snapshot.data.toString();
                        final custId = int.parse(cust);
                        UserProfile.dbUser = custId;
                     return FutureBuilder<List<WorkerEarning>>(
                      future: Services.getEarning(wid),
                      builder:  (context, snapshot) {
                        if (snapshot.hasData) {
                        List<WorkerEarning> workerEarning = snapshot.data;
                        if(workerEarning.isEmpty){
                            return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('My Earnings', style: largeFont()),
                          SizedBox(height: 10),
                          Text('Php 0.00', style: largeFont()),
                          SizedBox(height: 10),
                        ],
                      );
                      }
                        return ListView.builder(
                              itemCount: workerEarning.length,
                              itemBuilder:(context, int index){
                          return  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('My Earnings', style: largeFont()),
                          SizedBox(height: 10),
                          Text(workerEarning[index].earnings == null ? "Php 0.00"
                          :"Php " + workerEarning[index].earnings, style: largeFont()),
                          SizedBox(height: 10),
                          Text(workerEarning[index].updated == null ? ""
                          :"As of " + workerEarning[index].updated, style: tinyFont()),
                        ],
                      );
                                });
                          
                        }else if (snapshot.hasError) {
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
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
                          return Center(
                            child: SpinKitSquareCircle(
                                color: Color.fromRGBO(62, 135, 148, 1),
                                size: 50.0),
                          );
                      },
                    );
                      }),
                 
                  ),
                ),
              ),
            ),
          Divider(),
          Expanded(
            flex: 50,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Text(
                      'Job Postings',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder<List<DisplayPost>>(
                      future: Services.getPost(wid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DisplayPost> displayPost = snapshot.data;
                          if (displayPost.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/empty.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                 // height: MediaQuery.of(context).size.height * 0.5,
                                ),
                                SizedBox(height: 10),
                                Text('No work posts found',
                                    style: addressStyle()),
                              ],
                            );
                          } else {
                            List<DisplayPost> displayPost = snapshot.data;
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: ListView.builder(
                                itemCount: displayPost.length,
                                itemBuilder: (context, int index) {
                                  return postWidget(context, displayPost[index]);
                                },
                              ),
                            );
                          }
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
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
                              )
                            ],
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2
                          ),
                        child: Center(
                          child: SpinKitSquareCircle(
                              color: Color.fromRGBO(62, 135, 148, 1),
                              size: 50.0),
                        ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
