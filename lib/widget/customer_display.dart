import 'package:flutter/material.dart';

import '../models/cus_display_profile.dart';
import '../styles/style.dart';

class CustomerDisplay extends StatelessWidget {
  final List<CustomerProfile> customerProfile;
  CustomerDisplay(this.customerProfile);

  Widget customerDisplayProfile(BuildContext context, CustomerProfile customerProfile){
    return Row(
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
                    ),
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Image.network(customerProfile.profile, fit: BoxFit.cover),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(customerProfile.fname, style: profileName()),
                          SizedBox(width: 5),
                          Text(customerProfile.lname, style: profileName()),
                        ],
                      ),
                      Row(children: [
                        Text(customerProfile.zone, style: addressStyle()),
                        SizedBox(width: 5),
                        Text(customerProfile.barangay, style: addressStyle()),
                        SizedBox(width: 5),
                        Text(customerProfile.city, style: addressStyle()),
                      ],),
                    ],
                  ),
                ),
              ],
            );

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customerProfile.length,
      itemBuilder: (context, int currentIndex){
        return customerDisplayProfile(context, customerProfile[currentIndex],);
      }
      
    );
  }
}