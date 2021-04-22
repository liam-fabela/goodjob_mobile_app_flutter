import 'package:flutter/material.dart';

import '../styles/style.dart';

class CustomerRequest extends StatefulWidget {
  final int custId;
  CustomerRequest(this.custId);
  @override
  _CustomerRequestState createState() => _CustomerRequestState();
}

class _CustomerRequestState extends State<CustomerRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context,'My Requests'),

      
    );
  }
}