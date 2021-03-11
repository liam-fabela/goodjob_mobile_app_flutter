import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../helper/authenticate.dart';

class WorkerHoldingScreen extends StatelessWidget {
 
  void toggleView(){
     print('go back');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.2,
            // width: MediaQuery.of(context).size.width * 0.2,
            child: Image.asset(
              'assets/images/good_job.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),

            child: Column(
              children: [
                Text(
                  'Your application is currently reviewed.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                    'Please wait for an email from us for confirmation.', style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),),
                Text('Thank You!',style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,),),
              ],
            ),
          ),
          SizedBox(height: 20),
                
           GestureDetector(
                              onTap: (){
                             Navigator.pushReplacement(context,
                             MaterialPageRoute(builder: (context) => Authenticate(),),);
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
                                  'OK',
                                  style: mediumTextStyle(),
                                ),
                              ),
                   ),
        ],
      ),
    );
  }
}
