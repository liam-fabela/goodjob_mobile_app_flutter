import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../models/customer_request_display.dart';
import '../services/payment_services.dart';
import '../services/services.dart';


class PaymentUi extends StatefulWidget {
  final CustomerRequests value;
  
  PaymentUi({Key key, this.value}): super(key:key);

  @override
  _PaymentUiState createState() => _PaymentUiState();
}

class _PaymentUiState extends State<PaymentUi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController amount = TextEditingController();
  String due;

  @override
  void initState() {
     StripeService.init();
    int t = int.parse('${widget.value.time}');
   double a = double.parse('${widget.value.budget}');
    if(t == 0 ){
      //double p = a * 100;
      due = a.toInt().toString();
    }else{
      double hr = t/3600;
      double total = a * hr;
    //double amt = total * 100;

    String pay = total.toStringAsFixed(2);
    var arr = pay.split('.');
      due = arr[0] + "." + arr[1];
   }

    super.initState();
 }

  onItemPressed(BuildContext context,String amount) async{
    String price;
    if(amount.contains('.')){
      var arr = amount.split('.');
      price = arr[0] + arr[1];
   
    }else{
     price = amount + '00';
    }
    
//print(price);
      await StripeService.payWithNewCard(
         amount: price,
         currency: 'Php'
       ).then((response){

          showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: response.success ? Text(
                      'Transaction Successful.',
                      style: TextStyle(color: Colors.black),
                    ) : Text(
                      'Transaction Failed.',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: Text(response.message),
                    actions: <Widget>[
                      TextButton(
                        child: Center(
                          child: Text(
                            'Ok',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                         
                        },
                      ),
                    ],
                  ),
                );
       });
        
        
        
    
        
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(    
      key: _scaffoldKey,
      appBar: appBarSign(context, 'Payment Section'),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        height: MediaQuery.of(context).size.height*0.5,
        child: Center(
          child: Card(
                  elevation: 5,
              child: Container(
                //height: MediaQuery.of(context).size.height* 0.3,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(15),
                child: Column(children:[
                  Expanded(
                       child: ListTile(
                      leading:  CircleAvatar(
                          radius: 30,
                          //backgroundImage: NetworkImage(customerRequests.profile), 
                          backgroundColor:  Color.fromRGBO(75, 210, 178, 1),
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Text('PHP'),
                          ),
                        ),
                      title: Text("Php" +due),
                      subtitle: Column(
                        children: [
                          Text('Payment for work no: ${widget.value.jobId}'),
                          Text('Category: ${widget.value.category}'),
                          Text('Recipient: ${widget.value.fname} ${widget.value.lname}'),
                        ],
                      ),

                    ),
                  ),
                   GestureDetector(
                          onTap: (){
                           onItemPressed(context,due);
                           // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(amount.text),),);
                          },
                          child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          //height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                          color: Colors.blue,
                          //shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(15),
                          ),
                           child: Center(
                             child: Text('pay', style: TextStyle( fontSize: 16, color: Colors.white),
                        ),
                           ),
                    
                  ),
                      ),
                ]),
                     
                 
              ),
          ),
        ),
      ),
      
    );
  }
}