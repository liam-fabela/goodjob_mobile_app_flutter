import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../services/services.dart';
import '../models/worker_profile.dart';
import '../widget/workerlist.dart';

class WorkersList extends StatefulWidget {
  final int id;
  final String title;
  WorkersList(this.id, this.title);
  @override
  _WorkersListState createState() => _WorkersListState();
}

class _WorkersListState extends State<WorkersList> {
  List<WorkerProfiles> data;
 
  
  Future<void> _refreshData(int wid) async {
    setState(() {});
    return Services.getWorker(wid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, widget.title),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(widget.id),
        child: Center(
            child: FutureBuilder<List<WorkerProfiles>>(
                future: Services.getWorker(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //int dataLength = snapshot.data.length;
                    List<WorkerProfiles> workerProfiles = snapshot.data;
                    if (workerProfiles.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(height: 15),
                          Text(
                            'No workers yet.',
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
                    } else {
                      List<WorkerProfiles> workerProfiles = snapshot.data;
                      return WorkerListView(workerProfiles);
                    }
                  } else if (snapshot.hasError) {
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
                            _refreshData(widget.id);
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
                  return loadingScreen(context, 'Loading...');
                })),
      ),
    );
  }
}
