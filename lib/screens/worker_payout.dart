import 'package:flutter/material.dart';

import '../styles/style.dart';
class WorkerPayout extends StatefulWidget {
  final int wid;
  WorkerPayout(this.wid);
  @override
  _WorkerPayoutState createState() => _WorkerPayoutState();
}

class _WorkerPayoutState extends State<WorkerPayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Payout Section'),
      body: Container(),
      
    );
  }
}