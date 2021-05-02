import 'package:flutter/material.dart';

class WorkPostContainer extends StatefulWidget {
  @override
  _WorkPostContainerState createState() => _WorkPostContainerState();
}

class _WorkPostContainerState extends State<WorkPostContainer> {
  @override
  Widget build(BuildContext context) {
   return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      child: Text('Work Post Notifs'),
    );
  }
}