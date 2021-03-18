import 'package:flutter/material.dart';

class CustomerProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
         color: Color.fromRGBO(170, 225, 227, 0.3),
        child: Column(
          children: [
            Container(
               padding: EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
               ),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Row(children: [
                Container(
                   decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(1, 101, 105, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  color: Color.fromRGBO(170, 225, 227, 1),
                ),
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.15,
                  child: Icon(Icons.person)), 
                SizedBox(width: 10),
                Text('Customer name'),
              ],),
            ),
            SingleChildScrollView(
                child: Stack(children: [
                Container(
                  padding: EdgeInsets.only(
                top: 30,
               
               ),
                     decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),  
                    ),
                     color: Color.fromRGBO(62, 135, 148, 1)
                  ),
                      height: MediaQuery.of(context).size.height*0.65,
                    child: Container(

                        decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),  
                    ),
                     
                       color: Color.fromRGBO(75, 210, 178, 1),
                  ),
                      height: MediaQuery.of(context).size.height*0.30,
                      child: Center(child: Text('contents'),),
                    ),
                    ),
                    
                   
                    //width: MediaQuery.of(context).size.width * 0.85,
                   // padding: EdgeInsets.all(20.0),
              
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
