import 'package:flutter/material.dart';

import '../styles/style.dart';

class WorkerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                 margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, left: MediaQuery.of(context).size.width * 0.1),
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
                    color: Color.fromRGBO(89, 179, 150, 1),
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
