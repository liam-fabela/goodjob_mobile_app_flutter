import 'package:flutter/material.dart';

class WorkerCategoryScreen extends StatefulWidget {
  @override
  _WorkerCategoryScreenState createState() => _WorkerCategoryScreenState();
}

class _WorkerCategoryScreenState extends State<WorkerCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          child:
          Column(children: [
             Text('Welcome Worker!'),
            Text('To get started, select your work category/ies:'),
          ],),
        ),

      ],),
      
    );
  }
}