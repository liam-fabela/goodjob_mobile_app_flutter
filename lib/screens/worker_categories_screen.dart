import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styles/style.dart';
import '../services/services.dart';
import 'worker_home_screen.dart';


class WorkerCategoryScreen extends StatefulWidget {
  static const routeName = '/worker_category';
  @override
  _WorkerCategoryScreenState createState() => _WorkerCategoryScreenState();
}

class _WorkerCategoryScreenState extends State<WorkerCategoryScreen> {

  var firstVal = false;
  var secondVal = false;
  var thirdVal = false;
  var fourthVal = false;
  int first;
  int second;
  int third;
  int fourth;
  List dataValues;
  String uId;
  String username;
  int wId;
  var _isLoading = false;
  int userOfApp;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
     final data = ModalRoute.of(context).settings.arguments as Map<String, String>;
     uId = data['workerId'];
    username = data['username'];
    wId = int.parse(uId);
    super.didChangeDependencies();
  }

  _getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userOfApp = prefs.getInt('user');
  }


   _submitCategory(){
     if(firstVal) {
       first = 1;
     }
    if(secondVal) {
       second = 2;
     }
    if(thirdVal) {
       third = 3;
     }
    if(fourthVal) {
       fourth = 4;
     }
     print(wId);
     setState(() {
      _isLoading = true;
    });

     Services.insertCategory(wId, first, second, third, fourth).then((value){
       Navigator.of(context).pushReplacementNamed(
            WorkerHomeScreen.routeName,
            arguments: {
              "workerId": uId,
              "username": username,
            }
      );
     });


  }



  @override
  Widget build(BuildContext context) {
    return _isLoading ? loadingScreen(context, 'Welcome Worker! Please Wait for a moment.') :Scaffold(
      body: SingleChildScrollView(
        child:
        Column(
          children: [
             Container(
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              // width: MediaQuery.of(context).size.width * 0.2,
              child: Image.asset(
                'assets/images/good_job.png',
                fit: BoxFit.cover,
              ),
            ),
          Stack(
            children: [
               Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(1, 101, 105, 1),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Color.fromRGBO(170, 225, 227, 1),
                  ),
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       Expanded(
                         child: Column(
                           children: [
                              Text(
                                  'You are one step closer from becoming a worker!',
                                  style: TextStyle(
                                      color: Color.fromRGBO(62, 135, 148, 1),
                                      fontSize: 16,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                 Text(
                                  'Choose a work category/categories to activate your account.',
                                  style: TextStyle(
                                      color: Color.fromRGBO(62, 135, 148, 1),
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      ),
                                  textAlign: TextAlign.center,
                                  
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      CheckboxListTile(
                                        title: const Text('House Chore'),
                                        subtitle: const Text('Does different house chores'),
                                        value: firstVal,
                                         onChanged:(bool value) {
                                           setState(() {
                                             firstVal = value;
                                           });
                                           print(value);
                                         } ,
                                         ),
                                      CheckboxListTile(
                                        title: const Text('Personal Errand'),
                                        subtitle: const Text('Run errands for customers'),
                                        value: secondVal,
                                         onChanged: (bool value) {
                                           setState(() {
                                             secondVal = value;
                                           });
                                            print(value);
                                         } ,
                                         ),
                                      CheckboxListTile(
                                        title: const Text('Beauty & Grooming'),
                                        subtitle: const Text('Offers services for personal care'),
                                        value: thirdVal,
                                         onChanged: (bool value) {
                                           setState(() {
                                             thirdVal = value;
                                           });
                                            print(value);
                                         } ,
                                         ),
                                      CheckboxListTile(
                                        title: const Text('House Repair'),
                                        subtitle: const Text('Offers house repair services'),
                                        value: fourthVal,
                                         onChanged: (bool value) {
                                           setState(() {
                                             fourthVal = value;
                                           });
                                            print(value);
                                         } ,
                                         ),
                                    ]
                                  ),
                                ),

                           ]
                         )
                       ),
                        GestureDetector(
                              onTap: () {
                                _submitCategory();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(62, 135, 148, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Submit',
                                  style: mediumTextStyle(),
                                ),
                              ),
                            ),
                    ],
                  ),
               ),
            ],
          ),
          ],
        )
      ),
    );
  }
}