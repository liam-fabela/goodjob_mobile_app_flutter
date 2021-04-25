import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../styles/style.dart';
import '../helper/firebase_user.dart';
import '../helper/shared_preferences.dart';

class WorkerHomePage extends StatefulWidget {
  @override
  _WorkerHomePageState createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
   int wid;
@override
  void initState() {
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


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Card(
                   margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, bottom:  MediaQuery.of(context).size.height * 0.03, ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('My Earnings', style: largeFont()),
                      SizedBox(height:10),
                      Text('Php 0.00', style: largeFont()),
                      SizedBox(height: 10),
                      Text('As of', style: tinyFont()),
                    ],),
                  ),
                ),
              ),
              Divider(),
              Center(
              child: Text(
                'Job Postings',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            ],
          ),
    );
   
  }
}
