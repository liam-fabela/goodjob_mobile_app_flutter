import 'package:flutter/material.dart';

import '../models/customer_request_display.dart';
//import '../styles/style.dart';

class DeclineMessage extends StatefulWidget {
   final CustomerRequests value;
  DeclineMessage({Key key, this.value}) : super(key: key);
  @override
  _DeclineMessageState createState() => _DeclineMessageState();
}

class _DeclineMessageState extends State<DeclineMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}