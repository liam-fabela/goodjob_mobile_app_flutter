import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../styles/style.dart';

import '../services/services.dart';
import '../models/total_star.dart';
import '../helper/firebase_user.dart';
import '../models/customer_reviews.dart';
import '../widget/customer_review_list.dart';



class WorkerOwnRating extends StatefulWidget {
  @override
  _WorkerOwnRatingState createState() => _WorkerOwnRatingState();
}

class _WorkerOwnRatingState extends State<WorkerOwnRating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'My Ratings'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child:
              Container(
                child: FutureBuilder<List<TotalStar>>(
                  future: Services.getTotalRating(UserProfile.dbUser),
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      List<TotalStar> totalRating = snapshot.data;
                      if(totalRating.isEmpty){
                        return Row(children:[
                          Text('0', style: largeFont()),
                          SizedBox(width: 10),
                          Icon(Icons.thumb_up_alt_rounded, size: 50, color: Colors.white),
                        ]);
                      }
                      return ListView.builder(
                          itemCount: totalRating.length, 
                          itemBuilder: (context, int index){
                             return Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text(totalRating[index].rating, style: largeFont()),
                            SizedBox(width: 10),
                            Icon(Icons.thumb_up_alt_rounded, size: 50, color: Colors.white),
                          ],
                             );
                          }
                      );
                      }else if (snapshot.hasError) {
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
                              
                              ],
                            );
                          }
                           return Shimmer.fromColors(
                            child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text('0', style: largeFont()),
                            SizedBox(width: 10),
                            Icon(Icons.thumb_up_alt_rounded, size: 50, color: Colors.white),
                          ],
                             ),
                              baseColor: Colors.white,
                               highlightColor: Color.fromRGBO(62, 135, 148, 1), 
                           );
                      }
                ),

              ),
            ),
            Divider(

            ),
            Expanded(
               flex: 90,
               child:FutureBuilder<List<CustomerReviews>>(
                 future: Services.getReviews(UserProfile.dbUser),
              builder: (context, snapshot) {
                 if (snapshot.hasData) {
                  List<CustomerReviews> customerReviews = snapshot.data;
                  if (customerReviews.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'No reviews yet.',
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
                  } else {
                    return ReviewList(customerReviews);
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
                        onTap: (){},//() => _refreshData(wid),
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
                 return Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2
                          ),
                        child: Center(
                          child: SpinKitSquareCircle(
                              color: Color.fromRGBO(62, 135, 148, 1),
                              size: 50.0),
                        ),
                        );
              }
              
               ),
            ),
          ],
        ),
      ),

      
    );
  }
}