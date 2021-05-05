import 'package:flutter/material.dart';

import 'customer_post_notif.dart';

class WorkPostContainer extends StatefulWidget {
  final int cid;
  WorkPostContainer(this.cid);
  @override
  _WorkPostContainerState createState() => _WorkPostContainerState();
}

class _WorkPostContainerState extends State<WorkPostContainer> {
  @override
  Widget build(BuildContext context) {
   return Container(
      padding: EdgeInsets.only(bottom: 10),
      height: MediaQuery.of(context).size.height,
      child: CustomerPostNotification(widget.cid),
    );
  }
}