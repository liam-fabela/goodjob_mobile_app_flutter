import 'package:flutter/material.dart';

import '../styles/style.dart';

class AcceptedWorksPage extends StatefulWidget {
  final int wid;
  AcceptedWorksPage(this.wid);
  @override
  _AcceptedWorksPageState createState() => _AcceptedWorksPageState();
}

class _AcceptedWorksPageState extends State<AcceptedWorksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Accepted Works'),
      body: Container(
        height: MediaQuery.of(context).size.height,
      ),
      
    );
  }
}