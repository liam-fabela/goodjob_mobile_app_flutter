import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../models/customer_request_display.dart';

class CustomerRequestList extends StatefulWidget {
  final List<CustomerRequests> customerRequests;
  CustomerRequestList(this.customerRequests);
  @override
  _CustomerRequestListState createState() => _CustomerRequestListState();
}

class _CustomerRequestListState extends State<CustomerRequestList> {

  Widget listWidget(BuildContext context,CustomerRequests customerRequests){
    return Card(
      elevation: 5,
       margin: EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 5,
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListTile(
          leading: CircleAvatar(
                        radius: 30, 
                        backgroundColor:  Color.fromRGBO(75, 210, 178, 1),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.hourglass_top_rounded, size: 30),
                        ),
                      ),
          title: Text("Request ID "+customerRequests.jobId, style: profileName()),
          subtitle: Column(children: [
                    Text(customerRequests.fname +" " +customerRequests.lname, style:  addressStyle()),
                    Text(customerRequests.status, style: customerRequests.status == 'pending' ? pending()
                    : customerRequests.status == 'accepted' ? accepted()
                    : done()
                    ),
          ],),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.customerRequests.length,
      itemBuilder: (context, int currentIndex) {
        return listWidget(context, widget.customerRequests[currentIndex],);
      }
      
    );
  }
}