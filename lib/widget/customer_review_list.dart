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
            children: [
              customerReviews.rating == '1.0'
                  ? Icon(Icons.star, size: 20, color: Colors.yellow)
                  : customerReviews.rating == '2.0'
                      ? Row(
                          children: [
                            Icon(Icons.star, size: 20, color: Colors.yellow),
                            Icon(Icons.star, size: 20, color: Colors.yellow)
                          ],
                        )
                      : customerReviews.rating == '3.0'
                          ? Row(
                              children: [
                                Icon(Icons.star,
                                    size: 20, color: Colors.yellow),
                                Icon(Icons.star,
                                    size: 20, color: Colors.yellow),
                                Icon(Icons.star,
                                    size: 20, color: Colors.yellow),
                              ],
                            )
                          : customerReviews.rating == '4.0'
                              ? Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: 20, color: Colors.yellow),
                                    Icon(Icons.star,
                                        size: 20, color: Colors.yellow),
                                    Icon(Icons.star,
                                        size: 20, color: Colors.yellow),
                                    Icon(Icons.star,
                                        size: 20, color: Colors.yellow),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: 20, color: Colors.yellow),
                                    Icon(Icons.star,
                                        size: 20, color: Colors.yellow),
                                    Icon(Icons.star,
                                        size: 20, color: Colors.yellow),
                                    Icon(Icons.star,
                                        size: 20, color: Colors.yellow),
                                    Icon(Icons.star,
                                        size: 20, color: Colors.yellow),
                                  ],
                                ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(customerReviews.review, style: reviewStyle()),
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
