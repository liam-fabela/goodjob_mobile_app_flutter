import 'package:flutter/material.dart';

import '../styles/style.dart';

class FinishedWorksPage extends StatefulWidget {
  final int wid;
  FinishedWorksPage(this.wid);
  @override
  _FinishedWorksPageState createState() => _FinishedWorksPageState();
}

class _FinishedWorksPageState extends State<FinishedWorksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context,'Finished Works'),
      body: Container(),
      
    );
  }
}