import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:ntp/ntp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../helper/firebase_user.dart';
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
  TextEditingController review = TextEditingController();
  double _ratingValue;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    final map =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    id = map['id'];
    wid = int.parse(id);
    super.didChangeDependencies();
  }

  Future<void> _refreshData(int wid) async {
    setState(() {});
    return Services.getReviews(wid);
  }

  _showReviewForm(
      BuildContext context, int cid, int wid) {
    Alert(
        context: context,
        title: 'Rate Worker',
        content: Column(
              children: [
                TextFormField(
                  controller: review,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your review',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  maxLines: 5,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //color: Color.fromRGBO(53, 173, 207, 1),),
                  child: RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: Icon(Icons.thumb_up_rounded,
                          color: Color.fromRGBO(65, 136, 145, 1)),
                      half: Icon(Icons.thumb_up_rounded,
                          color: Color.fromRGBO(65, 136, 145, 1)),
                      empty: Icon(Icons.thumb_up_alt_outlined,
                          color: Color.fromRGBO(65, 136, 145, 1)),
                    ),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
         
        buttons: [
          DialogButton(
            onPressed: () async {
              var _myTime = await NTP.now();
              String date = _myTime.toString();
              ProgressDialog dialog = new ProgressDialog(context);
              dialog.style(
                message: 'Sending Review...',
              );
              await dialog.show();
              await Services.addReview(cid, wid, _ratingValue, review.text, date).then((value) {
                setState(() {
                  _isLoading = false;
                });
                 review.clear();
                dialog.hide();
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "Success!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Color.fromRGBO(91, 168, 144, 1),
                    textColor: Colors.white,
                    fontSize: 14);
              });
            },
            color: Color.fromRGBO(62, 135, 148, 1),
            child: Text("SUBMIT", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ]).show();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rate Worker',
          style: mediumTextStyle(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              _showReviewForm(context,UserProfile.dbUser, wid);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(wid),
        child: Center(
          child: FutureBuilder<List<CustomerReviews>>(
              future: Services.getReviews(wid),
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
                        onTap: () => _refreshData(wid),
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
                return loadingScreen(context, 'Loading...');
              }),
        ),
      ),
    );
  }
}
