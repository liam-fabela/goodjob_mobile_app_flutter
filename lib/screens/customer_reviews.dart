import 'package:flutter/material.dart';

import '../models/customer_reviews.dart';
import '../services/services.dart';
import '../styles/style.dart';
import '../widget/customer_review_list.dart';

class CustomerReviewScreen extends StatefulWidget {
  static const routeName = '/reviews_screen';
  @override
  _CustomerReviewScreenState createState() => _CustomerReviewScreenState();
}

class _CustomerReviewScreenState extends State<CustomerReviewScreen> {
  String id;
  int wid;

  @override
  void didChangeDependencies() {
    final map = ModalRoute.of(context).settings.arguments as Map<String, String>;
    id = map['id'];
    wid = int.parse(id);
    super.didChangeDependencies();
  }

  Future<void> _refreshData(int wid) async {
    setState(() {
      
    });
    return Services.getReviews(wid);
    
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Reviews'),
      body: RefreshIndicator(
            onRefresh: ()=> _refreshData(wid),
              child: Center(
          child: FutureBuilder<List<CustomerReviews>>(
            future: Services.getReviews(wid),
            builder: (context,snapshot) {
            if(snapshot.hasData) {
              List<CustomerReviews> customerReviews = snapshot.data;
               if(customerReviews.isEmpty) {
                return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_border_outlined,size:50, color: Colors.white,),
                    SizedBox(height:15),
                        Text('No reviews yet.',style: TextStyle(
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
                return ReviewList(customerReviews);
              }
            }else if(snapshot.hasError) {
               return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.wifi_off_outlined,size:50, color: Colors.white,),
                    SizedBox(height:15),
                    Text('Connection error.',style: TextStyle(
                                          color: Color.fromRGBO(62, 135, 148, 1),
                                          fontSize: 12,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.center,
                                    ), 
                      SizedBox(height:15),
                      GestureDetector(
                                  onTap:()=> _refreshData(wid),
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
                  ],);
            }
             return loadingScreen(context,'Loading...');

              
             
            }
          ),
        ),
      )
      
    );
  }
}