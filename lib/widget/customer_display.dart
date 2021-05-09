import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:shimmer/shimmer.dart';
import 'dart:ui';

import '../models/cus_display_profile.dart';
import '../styles/style.dart';
import '../services/services.dart';

class CustomerDisplay extends StatefulWidget {
  final int id;
  CustomerDisplay(this.id);

  @override
  _CustomerDisplayState createState() => _CustomerDisplayState();
}

class _CustomerDisplayState extends State<CustomerDisplay> {
  
  
  Widget customerDisplayProfile(
      BuildContext context, CustomerProfile customerProfile) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(customerProfile.profile),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: 40,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Row(
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
                      image: NetworkImage(customerProfile.profile),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop)
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(customerProfile.fname, style: profileName3()),
                          SizedBox(width: 5),
                          Text(customerProfile.lname, style: profileName3()),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            customerProfile.zone +
                                " " +
                                customerProfile.barangay,
                            style: addressStyle3(),
                          ),
                          Text(
                            customerProfile.city,
                            style: addressStyle3(),
                          ),
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
        future: Services.getCustomerDisplay(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CustomerProfile> customerProfile = snapshot.data;
           
                return Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: customerProfile.length,
                    itemBuilder: (context, int currentIndex) {
                      return customerDisplayProfile(
                        context,
                        customerProfile[currentIndex],
                      );
                    }),
              );
          } else if (snapshot.hasError) {
            return shimmerEffect(context);
          }
          return shimmerEffect(context);
        });
  }
}
