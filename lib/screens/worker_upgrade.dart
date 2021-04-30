import 'package:flutter/material.dart';

import '../styles/style.dart';

class WorkerUpgrade extends StatefulWidget {
  final int wid;
  WorkerUpgrade(this.wid);
  @override
  _WorkerUpgradeState createState() => _WorkerUpgradeState();
}

class _WorkerUpgradeState extends State<WorkerUpgrade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Upgrade Credibility'),
      body: Container(),
      
    );
  }
}