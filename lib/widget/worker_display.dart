import 'package:flutter/material.dart';
//import 'package:shimmer/shimmer.dart';
import 'dart:ui';

import '../models/worker_display_profile.dart';
import '../styles/style.dart';
import '../services/services.dart';

class WorkerDisplay extends StatelessWidget {
  final int id;
  WorkerDisplay(this.id);

  Widget workerDisplayProfile(BuildContext context, WorkerProfile workerProfile){
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(workerProfile.profile),
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
                      image: NetworkImage(workerProfile.profile),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(workerProfile.fname, style: profileName2()),
                          SizedBox(width: 5),
                          Text(workerProfile.lname, style: profileName2()),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              workerProfile.zone,
                              style: addressStyle2(),
                            ),
                            Text(
                              workerProfile.barangay,
                              style: addressStyle2(),
                            ),
                            Text(
                              workerProfile.city,
                              style: addressStyle2(),
                            ),
                          ],
                        ),
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
   return FutureBuilder<List<WorkerProfile>>(
        future: Services.getWorkerDisplay(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<WorkerProfile> workerProfile = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: workerProfile.length,
                  itemBuilder: (context, int currentIndex) {
                    return workerDisplayProfile(
                      context,
                      workerProfile[currentIndex],
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