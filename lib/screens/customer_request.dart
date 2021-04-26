import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../models/customer_request_display.dart';
import '../services/services.dart';
import '../widget/cust_request_list.dart';

class CustomerRequest extends StatefulWidget {
  final int custId;
  CustomerRequest(this.custId);
  @override
  _CustomerRequestState createState() => _CustomerRequestState();
}

class _CustomerRequestState extends State<CustomerRequest> {
 // var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context,'My Requests'),
      body: Center(
        child: FutureBuilder<List<CustomerRequests>>(
          future: Services.getAllCustomerRequest(widget.custId),
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
                  return CustomerRequestList(customerRequests);
               }

            } else if (snapshot.hasError) {
              return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Connection error.',
                          style: TextStyle(
                            color: Color.fromRGBO(62, 135, 148, 1),
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                           // _refreshData(widget.id);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(62, 135, 148, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Try Again',
                              style: mediumTextStyle(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return loadingScreen(context, 'Loading...');
          },
      ),),

      
    );
  }
}