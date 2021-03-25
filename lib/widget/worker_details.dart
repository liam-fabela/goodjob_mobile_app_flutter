import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

import '../styles/style.dart';
import 'worker_listbuilder.dart';
import '../models/worker_individual.dart';

class WorkerDetails extends StatefulWidget {
  static const routeName = '/worker_details';
  final List<WorkerIndividual> workerIndividual;

  WorkerDetails(this.workerIndividual);
 
  @override
  _WorkerDetailsState createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails> {

  String firstHalf;
  String secondHalf;
  double cardSize;

  void extendCard(BuildContext context ,String text) {
    if(text.length > 100) {
      firstHalf = text.substring(0, 100);
      secondHalf = text.substring(100, text.length);
      setState(() {
        cardSize = MediaQuery.of(context).size.height * 0.45;
      });
    }else{
      firstHalf = text;
      secondHalf = '';
    }

  }

  Widget workerProfile(BuildContext context, WorkerIndividual workerIndividual) {
       return SingleChildScrollView(
          child: Column(
          children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  //  gradient: LinearGradient(
                  //    begin: Alignment.topCenter,
                 //     end: Alignment.bottomCenter,
                 //     colors: [
                 //       Color.fromRGBO(29, 151, 108,1),
                 //       Color.fromRGBO(86, 180, 211,1),
                 //    
                 color: Colors.white,
                 // ],
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
                       // color: Color.fromRGBO(62, 135, 148, 1),
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(29, 151, 108,1),
                        Color.fromRGBO(86, 180, 211,1),
                      ],
                    ),
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
            ),
                ),
              ),
               Positioned(
                 top: MediaQuery.of(context).size.height * 0.52,
                right: MediaQuery.of(context).size.width * 0.090,
                 child: Container(
                   height: MediaQuery.of(context).size.height * 0.20,
                   width: MediaQuery.of(context).size.width * 0.80,
                   child: ProfileListBuilder()),
               ),
               Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                right: MediaQuery.of(context).size.width * 0.099,
                    child: Card(
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
                                  height: MediaQuery.of(context).size.height * 0.45,
                                  padding: EdgeInsets.all(20),
                                  child:Column(children: [
                                    Row(
                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Expanded(
                                        child: Row(children: [
                                          Text(workerIndividual.rating == null ? '0' : workerIndividual.rating, style:profileName(),),
                                          SizedBox(width: 5),
                                          Icon(Icons.star, color: Colors.yellow,),
                                        ]),
                                      ),
                                      Stack(
                          children: [
                            Container(
                              //padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.10,
                              child: Image.network(workerIndividual.badge),  
                            ),
                              Positioned(
                      bottom: 10,
                      right: 5,
                      child: Container(
                       // width: MediaQuery.of(context).size.width * 0.6,
                        color: Color.fromRGBO(29, 171, 145, 0.7),
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal:5),
                        child: Text(
                          'credibility',
                          style: TextStyle(
                           fontSize: 8,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                          ],
                        ),
                                    ],),
                       // SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(workerIndividual.fname, style: profileName()),
                            SizedBox(width: 10),
                            Text(workerIndividual.lname, style: profileName()),
                        ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(workerIndividual.zone, style: addressStyle()),
                            SizedBox(width: 5),
                            Text(workerIndividual.barangay, style: addressStyle()),
                            SizedBox(width: 5,),
                            Text(workerIndividual.city, style: addressStyle()),

                        ],),
                        SizedBox(height: 5),
                            Center(
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                Text('About:', style:addressStyle()),
                                ExpandableText(
                                   workerIndividual.about == null ? '' : workerIndividual.about ,style:addressStyle(),
                                   collapseText: 'Show less',
                                   expandText: 'Show More',
                                   )

                              ],),
                            ),
                                  ],),
                                )
                                ),
               ),
              Positioned(
                
                 top: MediaQuery.of(context).size.height * 0.07,
                 right: MediaQuery.of(context).size.width * 0.34,
                  child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.16,
                      backgroundColor: Colors.white,
                       child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.15,
                      backgroundImage: NetworkImage(workerIndividual.profile),
                    ),
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
      );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.workerIndividual.length,
      itemBuilder: (context, int currentIndex){
        return workerProfile(context, widget.workerIndividual[currentIndex],);
      },
          
    
    );
  }
}