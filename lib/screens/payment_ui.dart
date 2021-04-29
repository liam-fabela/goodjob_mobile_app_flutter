import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

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

  String due;
  var _isLoading = false;

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

  onItemPressed(BuildContext context,String amount, int jobId ) async{
     setState(() {
      _isLoading = true;
    });
    String price;
    var _myTime = await NTP.now();
    String updated = _myTime.toString();
   
    double payment = double.parse(amount);
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
          print("updated:" + updated);
          Services.updatePayment(jobId,'paid',updated, payment);
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
                          setState(() {
      _isLoading = false;
    });
                          Navigator.of(context).pop();
                         
                        },
                      ),
                    ],
                  ),
                );
       }); 
        
  }

  appBarWidget(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.07;
    double progressBarHeight = 7;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight + progressBarHeight),
      child: AppBar(
        title: Text('Payment Section'),
        titleSpacing: 5,
        bottom: linearProgressBar(progressBarHeight),
      ),
    );
  }

  linearProgressBar(_height) {
    if (!_isLoading) {
      return null;
    }
    return PreferredSize(
      child: SizedBox(
        width: double.infinity,
        height: _height,
        child: LinearProgressIndicator(
          backgroundColor: Colors.cyanAccent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
      preferredSize: const Size.fromHeight(0),
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(    
      appBar: appBarWidget(context),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        //height: MediaQuery.of(context).size.height*0.8,
        child: Center(
          child: Card(
                  elevation: 5,
                
              child: Container(
                height: MediaQuery.of(context).size.height* 0.4,
               // width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(20),
                child: Column(
                  
                  children:[
                  Expanded(
                    flex: 40,
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
                      title: Text("Php" + " "+ due, style: profileName(),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Payment for work # ${widget.value.jobId}',style: addressStyle()),
                          Text('Category: ${widget.value.category}', style: addressStyle()),
                          Text('Recipient: ${widget.value.fname} ${widget.value.lname}',style: addressStyle()),
                        ],
                      ),

                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child:Column(
                      children: [
                  Text('Accepted Cards',style: addressStyle()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Image.asset('assets/images/mastercard.png' ,width: MediaQuery.of(context).size.width * 0.1, fit: BoxFit.cover),
                    Image.asset('assets/images/visa.png' ,width: MediaQuery.of(context).size.width * 0.1, fit: BoxFit.cover),
                    
                //    Image.network('https://www.flaticon.com/svg/vstatic/svg/349/349221.svg?toker=exp=1619588887~hmac=41d1036ec639393404e63599d4f47', 
                //    width: MediaQuery.of(context).size.width*0.1, fit: BoxFit.cover),
                  ]),
                      ],
                    ),
                  ),
                  Divider(),
                   GestureDetector(
                          onTap: (){
                            int id = int.parse('${widget.value.jobId}');
                           onItemPressed(context,due,id);
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
                             child: Text('pay', style: TextStyle( fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)
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