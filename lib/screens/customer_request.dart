import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../models/customer_request_display.dart';
import '../services/services.dart';

class CustomerRequest extends StatefulWidget {
  final int custId;
  CustomerRequest(this.custId);
  @override
  _CustomerRequestState createState() => _CustomerRequestState();
}

class _CustomerRequestState extends State<CustomerRequest> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context,'My Requests'),
      body: Center(
        child: FutureBuilder<List<CustomerRequests>>(
          future: Services.getCustomerRequest(widget.custId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               List<CustomerRequests> customerRequests = snapshot.data;
               if(customerRequests.isEmpty){
                  return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.article_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(height: 15),
                          Text(
                            'No request made.',
                            style: TextStyle(
                              color: Color.fromRGBO(62, 135, 148, 1),
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
               }else{
                  List<CustomerRequests> customerRequests = snapshot.data;
                  
               }

            }
          },
      ),),

      
    );
  }
}