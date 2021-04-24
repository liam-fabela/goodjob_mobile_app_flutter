import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../models/wor_request_display.dart';
import '../styles/style.dart';
import 'dynamic_map.dart';
import '../services/services.dart';

class RequestDetails extends StatefulWidget {
  final WorkerRequests value;
  RequestDetails({Key key, this.value}) : super(key: key);
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  var _isLoading = false;

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

  _updateStatus(int jobId) async {
    try {
      ProgressDialog dialog = new ProgressDialog(context);
      dialog.style(
        message: 'Accepting request...',
      );
      await dialog.show();
      await Services.updateAcceptRequest(jobId).then((val) {
        setState(() {
          _isLoading = false;
        });
        dialog.hide();
        Navigator.pop(context);
      });
    } catch (error) {
       return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.wifi_off_outlined,size:50, color: Colors.white,),
                    SizedBox(height:15),
                    Text('Connection error.',style: TextStyle(
                                          color: Color.fromRGBO(62, 135, 148, 1),
                                          fontSize: 12,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.center,
                                    ), 
                      SizedBox(height:15),
                      GestureDetector(
                                  onTap:()=> (){},//_refreshData(wid),
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
                  ],);
        

    }
  }

  appBarWidget(BuildContext context, String loc) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.07;
    double progressBarHeight = 7;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight + progressBarHeight),
      child: AppBar(
        title: Text('Details'),
        titleSpacing: 5,
        bottom: linearProgressBar(progressBarHeight),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.map),
              iconSize: 25,
              tooltip: 'View Map',
              onPressed: () {
                _getCurrentUserLocation(context, loc);
              },
            ),
          ),
        ],
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
        child: LinearProgressIndicator(),
      ),
      preferredSize: const Size.fromHeight(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, '${widget.value.location}'),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.only(
          top: 30,
          left: 10,
          right: 10,
        ),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 80,
              child: Container(
                child: ListTile(
                  title: Text('${widget.value.category}', style: profileName()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: " + '${widget.value.date}',
                        style: addressStyle4(),
                      ),
                      Row(
                        children: [
                          Text("Time: ", style: addressStyle4()),
                          Text(
                            '${widget.value.startTime}',
                            style: addressStyle4(),
                          ),
                          Text(
                            '${widget.value.endTime}' == null
                                ? "  "
                                : " - " + '${widget.value.endTime}',
                            style: addressStyle4(),
                          ),
                        ],
                      ),
                      Text(
                        "Location: " + '${widget.value.location}',
                        style: addressStyle4(),
                      ),
                      Text(
                        "Budget: " +
                            '${widget.value.budget}' +
                            "/" +
                            '${widget.value.type}',
                        style: addressStyle4(),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Work Details: ",
                        style: addressStyle4(),
                      ),
                      Text(
                        '${widget.value.details}',
                        style: addressStyle4(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Expanded(
              flex: 20,
              child: Container(
                // alignment: Alignment.bottomCenter,
                child: Row(
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
                            showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Work Request.', style: TextStyle(color: Colors.black),),
                content: SingleChildScrollView(child:ListBody(children: [
                   Text('Are you sure you want to accept the request?.'),
                ],)),
                actions: <Widget>[
                 
                  TextButton(
                    child: Center(child: Text('Yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
                    onPressed: () {
                      int id = int.parse('${widget.value.jobId}');
                       _updateStatus(id);
                    },
                  ),
                   TextButton(
                    child: Center(child: Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
                    onPressed: () {
                       Navigator.of(context).pop();
                    },
                  ),
                ],
          ),
         );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
