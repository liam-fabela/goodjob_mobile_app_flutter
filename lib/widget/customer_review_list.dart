import 'package:flutter/material.dart';

import '../models/customer_reviews.dart';
import '../styles/style.dart';

class ReviewList extends StatelessWidget {
  final List<CustomerReviews> customerReviews;

  ReviewList(this.customerReviews);

  Widget reviewItem(BuildContext context, CustomerReviews customerReviews) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 5,
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(customerReviews.profile),
            child: Padding(
              padding: EdgeInsets.all(6),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Row(children: [
                  Text(customerReviews.fname, style: addressStyle()),
                  SizedBox(width: 5),
                  Text(customerReviews.lname, style: addressStyle()),
                ]),
              ),
              Text(customerReviews.date,
                  style: TextStyle(fontSize: 10, fontFamily: 'Raleway')),
            ],
          ),
          subtitle: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customerReviews.rating == '1.0'
                  ? Icon(
                      Icons.thumb_up_rounded,
                      size: 20,
                      color: Color.fromRGBO(65, 136, 145, 1),
                    )
                  : customerReviews.rating == '2.0'
                      ? Row(
                          children: [
                            Icon(
                              Icons.thumb_up_rounded,
                              size: 20,
                              color: Color.fromRGBO(65, 136, 145, 1),
                            ),
                            Icon(
                              Icons.thumb_up_rounded,
                              size: 20,
                              color: Color.fromRGBO(65, 136, 145, 1),
                            ),
                          ],
                        )
                      : customerReviews.rating == '3.0'
                          ? Row(
                              children: [
                                Icon(
                                  Icons.thumb_up_rounded,
                                  size: 20,
                                  color: Color.fromRGBO(65, 136, 145, 1),
                                ),
                                Icon(
                                  Icons.thumb_up_rounded,
                                  size: 20,
                                  color: Color.fromRGBO(65, 136, 145, 1),
                                ),
                                Icon(
                                  Icons.thumb_up_rounded,
                                  size: 20,
                                  color: Color.fromRGBO(65, 136, 145, 1),
                                ),
                              ],
                            )
                          : customerReviews.rating == '4.0'
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up_rounded,
                                      size: 20,
                                      color: Color.fromRGBO(65, 136, 145, 1),
                                    ),
                                    Icon(
                                      Icons.thumb_up_rounded,
                                      size: 20,
                                      color: Color.fromRGBO(65, 136, 145, 1),
                                    ),
                                    Icon(
                                      Icons.thumb_up_rounded,
                                      size: 20,
                                      color: Color.fromRGBO(65, 136, 145, 1),
                                    ),
                                    Icon(
                                      Icons.thumb_up_rounded,
                                      size: 20,
                                      color: Color.fromRGBO(65, 136, 145, 1),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up_rounded,
                                      size: 20,
                                      color: Color.fromRGBO(65, 136, 145, 1),
                                    ),
                                    Icon(
                                      Icons.thumb_up_rounded,
                                      size: 20,
                                      color: Color.fromRGBO(65, 136, 145, 1),
                                    ),
                                    Icon(
                                      Icons.thumb_up_rounded,
                                      size: 20,
                                      color: Color.fromRGBO(65, 136, 145, 1),
                                    ),
                                    Icon(
                                      Icons.thumb_up_rounded,
                                      size: 20,
                                      color: Color.fromRGBO(65, 136, 145, 1),
                                    ),
                                    Icon(
                                      Icons.thumb_up_rounded,
                                      size: 20,
                                      color: Color.fromRGBO(65, 136, 145, 1),
                                    ),
                                  ],
                                ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customerReviews.review, style: reviewStyle(),),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: customerReviews.length,
        itemBuilder: (context, int currentIndex) {
          return reviewItem(
            context,
            customerReviews[currentIndex],
          );
        });
  }
}
