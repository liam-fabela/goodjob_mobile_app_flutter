import 'package:flutter/material.dart';

import '../helper/shared_preferences.dart';
import '../styles/style.dart';
import '../widget/chatrooms.dart';

class CustomerMessagePage extends StatefulWidget {
  @override
  _CustomerMessagePageState createState() => _CustomerMessagePageState();
}

class _CustomerMessagePageState extends State<CustomerMessagePage> {
   Future<int> tem;

  @override
  void initState() {
     tem = SharedPrefUtils.getUser('userId');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
       child: FutureBuilder(
          future: tem,
          builder: (context, snapshot){
            if(snapshot.connectionState != ConnectionState.done){
                           return shimmerEffect(context);
                        }
                        final cust = snapshot.data.toString();
                        final custId = int.parse(cust);
                        return ChatRooms(custId);
          },
       ),
    );
  }
}