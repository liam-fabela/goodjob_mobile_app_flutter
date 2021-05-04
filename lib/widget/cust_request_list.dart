import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles/style.dart';
import '../models/customer_request_display.dart';

class CustomerRequestList extends StatefulWidget {
  final List<CustomerRequests> customerRequests;
  CustomerRequestList(this.customerRequests);
  @override
  _CustomerRequestListState createState() => _CustomerRequestListState();
}

class _CustomerRequestListState extends State<CustomerRequestList> {
  formatTime(String time){
    //var format = DateFormat.jm();
    TimeOfDay _format = TimeOfDay(hour: int.parse(time.split(":")[0]),minute: int.parse(time.split(":")[1]));
    return _format;
     
  }

  DateFormat formatter = DateFormat('yyyy-MM-dd');
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
                          child: customerRequests.status == 'pending' ? Icon(Icons.hourglass_top_rounded, size: 30)
                          : customerRequests.status == 'accepted' ? Icon(Icons.check_circle_outline_outlined, size: 30)
                          : customerRequests.status == 'done' ?  Icon(Icons.check_circle, size: 30)
                          : customerRequests.status == 'paid' ? Icon(Icons.credit_card, size: 30)
                          :  Icon(Icons.cancel_outlined, size: 30)
                        ),
                      ),
          title: Text("Request ID "+customerRequests.jobId, style: profileName(),),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    Text(customerRequests.fname +" " +customerRequests.lname, style:  addressStyle(),),
                    SizedBox(height: 5),
                    Text(customerRequests.category ,style:  addressStyle()),
                     SizedBox(height: 5),
                    Text('${DateFormat.yMd().format(DateTime.parse(customerRequests.date))}' ,style:  addressStyle(),),
                     SizedBox(height: 5),
                     Row(
                       children: [
                         Text(customerRequests.startTime, style:  addressStyle(),),
                         Text(customerRequests.endTime == null ? '' : '-'),
                         Text(customerRequests.endTime == null ? '' : customerRequests.endTime, style: addressStyle(),),
                       ],
                     ),
                    Text("Status: "+customerRequests.status, style: customerRequests.status == 'pending' ? pending()
                    : customerRequests.status == 'accepted' ? accepted()
                    : customerRequests.status == 'done' ? done()
                    : customerRequests.status == 'paid' ? paid()
                    : declined(),
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