import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../styles/style.dart';
import '../services/services.dart';
import '../models/wor_accepted.dart';
import '../screens/dynamic_map.dart';
import '../screens/chat_screen.dart';

class AcceptedWorksPage extends StatefulWidget {
  final int wid;
  AcceptedWorksPage(this.wid);
  @override
  _AcceptedWorksPageState createState() => _AcceptedWorksPageState();
}

class _AcceptedWorksPageState extends State<AcceptedWorksPage> {
  var _isLoading = false;

   void _sendMessage(BuildContext context, String lname, String fname, String uid, String id, String profile) {
    String name = fname + ' ' + lname;
    int userId = int.parse(id);
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ChatScreen(name, uid, userId, profile,1),),);
  }

  Future<void> _getCurrentUserLocation(
      BuildContext context, String location) async {
    setState(() {
      _isLoading = true;
    });
    final query = location;
    var add = await Geocoder.local.findAddressesFromQuery(query);
    var first = add.first;
    var lat = first.coordinates.latitude;
    var long = first.coordinates.longitude;
    await Location().getLocation().then((value) {
      setState(() {
        _isLoading = !_isLoading;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                DynamicMap(value.latitude, value.longitude, lat, long),
            fullscreenDialog: true,
          ));
      print(value.latitude);
      print(value.longitude);
    });
  }

//  _updateStatus(int jobId) async {
//    try {
//      ProgressDialog dialog = new ProgressDialog(context);
//      dialog.style(
//        message: 'Accepting request...',
//      );
//      await dialog.show();
//      await Services.updateAcceptRequest(jobId, ).then((val) {
//        setState(() {
//          _isLoading = false;
//        });
//        dialog.hide();
//        Navigator.pop(context);
//      });
//    } catch (error) {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: [
//          Icon(
//            Icons.wifi_off_outlined,
//            size: 50,
//            color: Colors.white,
//          ),
//          SizedBox(height: 15),
//          Text(
//            'Connection error.',
//            style: TextStyle(
//              color: Color.fromRGBO(62, 135, 148, 1),
//              fontSize: 12,
//              fontFamily: 'Raleway',
//              fontWeight: FontWeight.bold,
//            ),
//            textAlign: TextAlign.center,
//          ),
//          SizedBox(height: 15),
//          GestureDetector(
//            onTap: () => () {}, //_refreshData(wid),
//            child: Container(
//              alignment: Alignment.center,
//              width: MediaQuery.of(context).size.width * 0.3,
//              padding: EdgeInsets.symmetric(
//                vertical: 10,
//              ),
//              decoration: BoxDecoration(
//                color: Color.fromRGBO(62, 135, 148, 1),
//                borderRadius: BorderRadius.circular(10),
//              ),
//              child: Text(
//                'Try Again',
//                style: mediumTextStyle(),
//              ),
//            ),
//          ),
//        ],
//      );
//    }
//  }

  appBarWidget(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.07;
    double progressBarHeight = 7;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight + progressBarHeight),
      child: AppBar(
        title: Text('Accepted'),
        titleSpacing: 5,
        bottom: linearProgressBar(progressBarHeight),
      ),
    );
  }

  linearProgressBar(_height) {
    if (!_isLoading) {
      return null;
    }
    return PreferredSize(
      child: SizedBox(
        width: double.infinity,
        height: _height,
        child: LinearProgressIndicator(
          backgroundColor: Colors.cyanAccent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
      preferredSize: const Size.fromHeight(0),
    );
  }

  listWidget(BuildContext context, WorkerAcceptedRequests workerRequest) {
    return Card(
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.only(
          top: 30,
          left: 10,
          right: 10,
        ),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                flex: 70,
                child: Container(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(workerRequest.profile),
                    backgroundColor: Color.fromRGBO(75, 210, 178, 1),
                    child: Padding(
                      padding: EdgeInsets.all(6),
                    ),
                  ),
                  title: Text(workerRequest.category, style: profileName()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Customer: " + workerRequest.fname + " " + workerRequest.lname, style: addressStyle4()),
                      Text("Date: " + workerRequest.date, style: addressStyle4()),
                      Row(
                        children: [
                          Text("Time: ", style: addressStyle4()),
                          Text(workerRequest.startTime, style:  addressStyle4()),
                          Text(workerRequest.endTime == null ? " "
                          : " - " + workerRequest.endTime,
                          style: addressStyle4(),
                          ),
                        ],
                      ),
                      Text("Location: " +workerRequest.location, style: addressStyle4()),
                      Text("Budget: " + workerRequest.budget + "/" + workerRequest.type,style: addressStyle4()),
                      SizedBox(height: 5),
                      Text("Details: ",style: addressStyle4()),
                      Text(workerRequest.details, style: addressStyle4()),
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Expanded(
              flex: 30,
              child: Column(
                children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                  GestureDetector(
                    onTap: (){
                      String id = widget.wid.toString();
                      _sendMessage(context, workerRequest.lname, workerRequest.fname, workerRequest.uid, id, workerRequest.profile);
                    },
                    child: Icon(Icons.messenger_outline, size: 35, color: Color.fromRGBO(36, 121, 138,1))),
                  GestureDetector(
                    onTap:(){
                      _getCurrentUserLocation(context, workerRequest.location);
                    },
                    child: Icon(Icons.map, size: 35, color: Color.fromRGBO(36, 121, 138,1))),
                ]),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Container(
                        //alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                           
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
                              'Accept',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Container(
                        //alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(145, 39, 39, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Decline',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ],
              ),
            ),
          ],
        ),
       
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: FutureBuilder<List<WorkerAcceptedRequests>>(
            future: Services.getWorkerAcceptedRequest(widget.wid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<WorkerAcceptedRequests> workerRequest = snapshot.data;
                if (workerRequest.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.work,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'No accepted request yet.',
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
                }
                return ListView.builder(
                  itemCount: workerRequest.length,
                  itemBuilder: (context, int currentIndex) {
                    return listWidget(context, workerRequest[currentIndex]);
                  },
                );
              }else if (snapshot.hasError){
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
                          onTap: () {
                            //_refreshData(widget.id);
                          },
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
         return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SpinKitSquareCircle(
                        color: Color.fromRGBO(62, 135, 148, 1), size: 50.0),
                  ),
                  SizedBox(height: 35),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Loading requests...',
                          style: TextStyle(
                            color: Colors.white54,
                            fontFamily: 'Raleway',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
