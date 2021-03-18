import 'package:flutter/material.dart';

import '../models/cust_profile.dart';

class CustomerGridItem extends StatelessWidget {

  final CustomerProfileGrid choice;

  const CustomerGridItem(this.choice);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Icon(choice.icon, size:50, color: Color.fromRGBO(62, 135, 148, 1),),),
            Text(choice.title, style: TextStyle(fontFamily: 'Raleway', fontSize: 16, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
