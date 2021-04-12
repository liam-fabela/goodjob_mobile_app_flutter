import 'package:flutter/material.dart';

import '../models/worker_profile.dart';
import '../screens/worker_profile_details.dart';
import '../styles/style.dart';
//import '../services/services.dart';
//import '../models/worker_rating.dart';

class WorkerListView extends StatefulWidget {
  final List<WorkerProfiles> workerProfiles;

  WorkerListView(this.workerProfiles);

  @override
  _WorkerListViewState createState() => _WorkerListViewState();
}

class _WorkerListViewState extends State<WorkerListView> {
   
 


  Widget workerViewItem(BuildContext context, WorkerProfiles workerProfiles) {
    return Card(
       elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 5,
      ),
     // padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListTile(
                 leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(workerProfiles.profile), 
                        backgroundColor:  Color.fromRGBO(75, 210, 178, 1),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                        ),
                      ),
                  title: Row(children: [
                          Text(workerProfiles.fname, style: profileName()),
                          SizedBox(width: 10),
                           Text(workerProfiles.lname, style: profileName()),

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
                           Text(workerProfiles.barangay, style: addressStyle()),
                           
                  ],),
                   Text(workerProfiles.city, style: addressStyle()),

                  ]),
                  trailing: 
                      Stack(
                        children: [
                          Container(
                            //padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: Image.network(workerProfiles.badge),
                            
                          ),
                            Positioned(
                    bottom: 10,
                    right: 5,
                    child: Container(
                     // width: MediaQuery.of(context).size.width * 0.6,
                      color: Color.fromRGBO(29, 171, 145, 0.7),
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal:5),
                      child: Text(
                        'credibility',
                        style: TextStyle(
                         fontSize: 8,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                        ],
                      ),
        onTap: (){
        // id = int.parse(workerProfiles.id);
          
      //  List data = Services.getRatings(wid);
      
           Navigator.pushNamed(context, ProfileDetails.routeName,
         arguments:{
           'id': workerProfiles.id,
           'category': workerProfiles.catType,
           'uid': workerProfiles.uid,
           }
         );
     
        
        },
        ),
      ),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.workerProfiles.length,
      itemBuilder: (context, int currentIndex) {
        return workerViewItem(context, widget.workerProfiles[currentIndex],);
      }
      
    );
  }
}