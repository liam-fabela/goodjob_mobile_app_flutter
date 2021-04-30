import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';



import '../services/services.dart';
import '../styles/style.dart';

class RatingReviewScreen extends StatefulWidget {
  @override
  _RatingReviewScreenState createState() => _RatingReviewScreenState();
}

class _RatingReviewScreenState extends State<RatingReviewScreen> {
  TextEditingController review = TextEditingController();
  double _ratingValue;
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, 'Review Section'),
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          child: Column(
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
                 SizedBox(height: 25,),
                Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),
                //color: Color.fromRGBO(53, 173, 207, 1),),
                child: RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.yellow),
                    half: Icon(Icons.star_half, color: Colors.yellow),
                    empty: Icon(Icons.star_outline, color: Colors.yellow),
                  ),
                  onRatingUpdate: (value){
                    setState(() {
                      _ratingValue = value;
                    });
                  },

                )

                ),
                  SizedBox(height: 25,),
                  GestureDetector(
                                onTap: () async{
                                 
                                 await Services.addReview(cid, wid, star, date)

                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                     color: Color.fromRGBO(62, 135, 148, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Send',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
            ],
          ),
        ),
      ),
      
    );
  }
}