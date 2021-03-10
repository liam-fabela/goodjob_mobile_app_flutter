import 'package:flutter/material.dart';

class WorkerOTPScreen extends StatefulWidget {
  @override
  _WorkerOTPScreenState createState() => _WorkerOTPScreenState();
}

class _WorkerOTPScreenState extends State<WorkerOTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              // width: MediaQuery.of(context).size.width * 0.2,
              child: Image.asset(
                'assets/images/good_job.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
