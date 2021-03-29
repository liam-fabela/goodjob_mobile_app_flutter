import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui';

import '../models/cus_display_profile.dart';
import '../styles/style.dart';
import '../services/services.dart';

class CustomerDisplay extends StatelessWidget {
  final int id;
  CustomerDisplay(this.id);

  Widget customerDisplayProfile(
      BuildContext context, CustomerProfile customerProfile) {
    return Stack(
      children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  NetworkImage(customerProfile.profile),
              fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.3,
         padding: EdgeInsets.all(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child:
      Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(1, 101, 105, 1),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: Color.fromRGBO(170, 225, 227, 1),
            image: DecorationImage(
              image:  NetworkImage(customerProfile.profile),
              fit: BoxFit.cover,
              ),
            ),
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.1, 
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(customerProfile.fname, style: profileName()),
                  SizedBox(width: 5),
                  Text(customerProfile.lname, style: profileName()),
                ],
              ),
              Row(
                children: [
                  Text(customerProfile.zone, style: addressStyle()),
                  SizedBox(width: 5),
                  Text(customerProfile.barangay, style: addressStyle()),
                  SizedBox(width: 5),
                  Text(customerProfile.city, style: addressStyle()),
                ],
              ),
            ],
          ),
        ),
      ],
      ),
      ),
      ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CustomerProfile>>(
        future: Services.getCustomerDisplay(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CustomerProfile> customerProfile = snapshot.data;
            return ListView.builder(
                itemCount: customerProfile.length,
                itemBuilder: (context, int currentIndex) {
                  return customerDisplayProfile(
                    context,
                    customerProfile[currentIndex],
                  );
                });
          } else if (snapshot.hasError) {
            return shimmerEffect(context);
          }
          return shimmerEffect(context);
        });
  }
}
