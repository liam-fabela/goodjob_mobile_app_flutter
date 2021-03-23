import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../widget/worker_listbuilder.dart';

class WorkerDetails extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, ''),     
      body: SingleChildScrollView(
          child: Column(
          children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(29, 151, 108,1),
                        Color.fromRGBO(86, 180, 211,1),
                      ],
                    ),
                  ),
                  child:Stack(
              children: [
                 // color: Color.fromRGBO(170, 225, 227,1),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height* 0.25,
                     padding: EdgeInsets.only(
                        top: 50,
                        left: 20,
                        right: 20,
                        bottom: 10,
                       ),
                 decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                         bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),  
                         ),
                        color: Color.fromRGBO(62, 135, 148, 1),
                      ),
                    child:
                        Container(
                          child:
                        Text('Profile',style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                     
                  ),
                ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                right: MediaQuery.of(context).size.width * 0.090,
                  child: Card(
                  shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
                  elevation: 5,
                  color: Colors.white,
                  child: Container(
                  //margin: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width * 0.80,
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: Column(children: [
                              Card(
                              elevation: 3,
                              margin: EdgeInsets.all(0),
                               shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.only(
                                 topLeft: Radius.circular(15),
                                topRight: Radius.circular(15), 
                               ),
                               ),
                              child: Container(
                                 width: MediaQuery.of(context).size.width * 0.80,
                                height: MediaQuery.of(context).size.height * 0.35,
                                padding: EdgeInsets.all(10),
                              )
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.20,
                                width: double.infinity,
                                child: ProfileListBuilder()),

                            ],
                            ),
            ),
                ),
              ),
              Positioned(
                
                 top: MediaQuery.of(context).size.height * 0.01,
                 right: MediaQuery.of(context).size.width * 0.35,
                  child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.30,
                   decoration: BoxDecoration(
                     border: Border.all(
                      color: Color.fromRGBO(1, 101, 105, 1),
                    ),
                         shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                  child: Icon(Icons.person),
                ),
              ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.15,
                  right: MediaQuery.of(context).size.width * 0.2,
                    child: GestureDetector(
                     onTap: (){},
                     child: Container(
                       alignment: Alignment.center,
                       width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.10,
                         padding: EdgeInsets.symmetric(
                          vertical: 5,
                          ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(62, 135, 148, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Hire Me',
                                    style: mediumTextStyle(),
                                  ),
                                ),
                     ),
                ),
              ],
                ),
            ),
           
            
          ],
        ),
      ), 
    );
  }
}