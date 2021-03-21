import 'package:flutter/material.dart';

import '../models/worker_profile.dart';

class WorkerListView extends StatelessWidget {
  final List<WorkerProfiles> workerProfiles;

  WorkerListView(this.workerProfiles);

  Widget workerViewItem(BuildContext context, WorkerProfiles workerProfiles) {
    return Card(
       elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
      ),
     // padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
                 leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Image.network(workerProfiles.profile), 
                          ),
                        ),
                      ),
                  title: Row(children: [
                          Text(workerProfiles.fname, style:  TextStyle(
                                        color: Color.fromRGBO(62, 135, 148, 1),
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        ),),
                          SizedBox(width: 10),
                           Text(workerProfiles.lname, style:  TextStyle(
                                        color: Color.fromRGBO(62, 135, 148, 1),
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        ),),

                  ],),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(children: [
                          Text(workerProfiles.zone, style:  TextStyle(
                                        color: Color.fromRGBO(62, 135, 148, 1),
                                        fontSize: 12,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        ),),
                          SizedBox(width: 10),
                           Text(workerProfiles.barangay, style:  TextStyle(
                                        color: Color.fromRGBO(62, 135, 148, 1),
                                        fontSize: 12,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        ),),
                           
                  ],),
                   Text(workerProfiles.city, style:  TextStyle(
                                        color: Color.fromRGBO(62, 135, 148, 1),
                                        fontSize: 12,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        ),),

                  ]),
                  trailing: 
                      Container(
                        //padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: Image.network(workerProfiles.badge),
                        
                      ),

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workerProfiles.length,
      itemBuilder: (context, int currentIndex) {
        return workerViewItem(context, workerProfiles[currentIndex],);
      }
      
    );
  }
}