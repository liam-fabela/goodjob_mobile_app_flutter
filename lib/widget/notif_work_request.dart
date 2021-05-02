import 'package:flutter/material.dart';


import 'customer_notification.dart';

class WorkRequestContainer extends StatefulWidget {
  final int cid;
  WorkRequestContainer(this.cid);
  
  @override
  _WorkRequestContainerState createState() => _WorkRequestContainerState();
}

class _WorkRequestContainerState extends State<WorkRequestContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      height: MediaQuery.of(context).size.height,
      child: CustomerNotifications(widget.cid),
    );
  }
}