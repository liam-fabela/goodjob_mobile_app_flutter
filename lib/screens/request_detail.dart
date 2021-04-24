import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../models/wor_request_display.dart';
import '../styles/style.dart';

class RequestDetails extends StatefulWidget {
  final WorkerRequests value;
  RequestDetails({Key key, this.value}) : super(key: key);
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
   var _isLoading = false;

    Future<void> _getCurrentUserLocation(BuildContext context) async {
 //     ProgressDialog dialog = new ProgressDialog(context);
 //     dialog.style(
//        message: 'Getting your location',
//      );
//      await dialog.show();
      await Location().getLocation().then((value){
        setState(() {
              _isLoading = false;
        });
//      dialog.hide();
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> DynamicMap(value.latitude,value.longitude), fullscreenDialog: true,));
      print(value.latitude);
      print(value.longitude);
    });
    
    
  }


  appBarWidget(BuildContext context, String loc){
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
            onPressed: (){},
          ),
        ),
      ],
    ),

  );


  }

  linearProgressBar(_height){
    if(!_isLoading){
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
      appBar:  appBarWidget(context, '${widget.value.location}'),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.only(top: 30, left: 10, right: 10,),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 80,
               child: Container(
                child: ListTile(
                  title:
                  Text('${widget.value.category}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: " + '${widget.value.date}',
                        style: addressStyle(),
                      ),
                      Text("Time: ", style: addressStyle()),
                      Row(
                        children: [
                          Text(
                            '${widget.value.startTime}',
                            style: addressStyle(),
                          ),
                          Text(
                            '${widget.value.endTime}' == null
                                ? "  "
                                : " - " + '${widget.value.endTime}',
                            style: addressStyle(),
                          ),
                        ],
                      ),
                      Text(
                        "Location: " + '${widget.value.location}',
                        style: addressStyle(),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Work Details: " + '${widget.value.details}',
                        style: addressStyle(),
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
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
