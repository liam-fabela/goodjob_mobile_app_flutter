import 'package:flutter/material.dart';
//import 'package:expandable_text/expandable_text.dart';

import '../styles/style.dart';
//import 'worker_listbuilder.dart';
import '../models/worker_individual.dart';
import '../screens/customer_reviews.dart';
import '../screens/create_work_request.dart';
import 'list_tile2.dart';

class WorkerDetails extends StatefulWidget {
  static const routeName = '/worker_details';
  final List<WorkerIndividual> workerIndividual;
  final String wid;

  WorkerDetails(this.workerIndividual, this.wid);

  @override
  _WorkerDetailsState createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails> {

//    List texts= ["The worker had provided an NBI clearance as his/her proof of identity.", "The worker had provided a Police clearance as his/her proof of identity.", "The worker had provided a Barangay clearance as his proof of identity."];
//    List texts2 = ["Highest credibility level","Middle-level credibility","Lowest Credibility level"];
//   void _openInfo(BuildContext ctx, String image, String title, String text){
//     showModalBottomSheet(
//      context: ctx,
//      builder: (_) {
//        return GestureDetector(
//          onTap: () {},
//          child: Container(
//            padding: EdgeInsets.all(5),
//            child: listTileInfo2(context,image, title, text), 
//      ),
///          behavior: HitTestBehavior.opaque,
//        );
//      },
 //   );
 // }


  void _createRequest(BuildContext context) {
     Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) =>  CreateWorkRequest(),
      ),
    );
  }

  void navigateReview(BuildContext context, String id){
    Navigator.of(context).pushNamed(CustomerReviewScreen.routeName, arguments: {
      'id': id,

    });
  }

  Widget workerProfile(
      BuildContext context, WorkerIndividual workerIndividual) {
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
            child: Stack(
              children: [
                // color: Color.fromRGBO(170, 225, 227,1),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
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
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(29, 151, 108, 1),
                        Color.fromRGBO(86, 180, 211, 1),
                      ],
                    ),
                  ),
                  child: Container(
                    child: Text(
                      'Profile',
                      style: TextStyle(
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
                  right: MediaQuery.of(context).size.width * 0.099,
                  child: Card(
                      elevation: 7,
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
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(children: [
                                    Text(
                                      workerIndividual.rating == null
                                          ? '0'
                                          : workerIndividual.rating,
                                      style: profileName(),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                  ]),
                                ),
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                      //  if(workerIndividual.docId == '1'){
                                      //    _openInfo(context, workerIndividual.badge,texts2[0],texts[0]);
                                      //  }else if(workerIndividual.docId == '2'){
                                      //     _openInfo(context, workerIndividual.badge,texts2[1],texts[1]);
                                      //  }else{
                                      //     _openInfo(context, workerIndividual.badge,texts2[2],texts[2]);
                                      //  }
                                      },
                                        child: Container(
                                        //padding: EdgeInsets.all(10),
                                        width: MediaQuery.of(context).size.width *
                                            0.15,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        child:
                                            Image.network(workerIndividual.badge),
                                      ),
                                    ),
                                   // Positioned(
                                    //  bottom: MediaQuery.of(context).size.height * 0.04,
                                     // right: MediaQuery.of(context).size.width * 0.05,
                                    //  child: Icon(Icons.info_outlined, size: 20,color: Colors.white54,),
                                   // ),
                                    Positioned(
                                      bottom: 10,
                                      right: 5,
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width * 0.6,
                                        color:
                                            Color.fromRGBO(29, 171, 145, 0.7),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
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
                              ],
                            ),
                            // SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(workerIndividual.fname,
                                    style: profileName()),
                                SizedBox(width: 10),
                                Text(workerIndividual.lname,
                                    style: profileName()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(workerIndividual.zone,
                                    style: addressStyle()),
                                SizedBox(width: 5),
                                Text(workerIndividual.barangay,
                                    style: addressStyle()),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(workerIndividual.city,
                                    style: addressStyle()),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'About:',
                                    style: addressStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    workerIndividual.about == null
                                        ? ''
                                        : workerIndividual.about,
                                    style: addressStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
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
                    onTap: () {
                      _createRequest(context);
                    },
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
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.6,
                  right: MediaQuery.of(context).size.width * 0.090,
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 2,
                        left: 2,
                        top: 10,
                        bottom: 10,
                      ),
                      // height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.messenger_outline,
                                    size: MediaQuery.of(context).size.width *
                                        0.08,
                                    color:
                                        const Color.fromRGBO(62, 135, 148, 1),
                                  )),
                              Text(
                                'Message',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Raleway',
                                  color: const Color.fromRGBO(62, 135, 148, 1),
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.today_outlined,
                                    size: MediaQuery.of(context).size.width *
                                        0.08,
                                    color:
                                        const Color.fromRGBO(62, 135, 148, 1),
                                  )),
                              Text(
                                'Schedule Calendar',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Raleway',
                                  color: const Color.fromRGBO(62, 135, 148, 1),
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    navigateReview(context,widget.wid);
                                  },
                                  child: Icon(
                                    Icons.star_outline_outlined,
                                    size: MediaQuery.of(context).size.width *
                                        0.08,
                                    color:
                                        const Color.fromRGBO(62, 135, 148, 1),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    workerIndividual.review,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Raleway',
                                      color:
                                          const Color.fromRGBO(62, 135, 148, 1),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Raleway',
                                      color:
                                          const Color.fromRGBO(62, 135, 148, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                        ],
                      ),
                      //ProfileListBuilder()
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
      itemBuilder: (context, int currentIndex) {
        return workerProfile(
          context,
          widget.workerIndividual[currentIndex],
        );
      },
    );
  }
}
