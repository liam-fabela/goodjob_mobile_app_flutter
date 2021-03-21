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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSign(context, widget.title),
      body: Center(
        child: FutureBuilder<List<WorkerProfiles>>(
          future: Services.getWorker(widget.id),
          builder: (context,snapshot) {
            if(snapshot.hasData) {
              List<WorkerProfiles> workerProfiles = snapshot.data;
              return WorkerListView(workerProfiles);
            }else if(snapshot.hasError){
          showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Connection Error.', style: TextStyle(color: Colors.black),),
                content: SingleChildScrollView(child:ListBody(children: [
                   Text('Please check your connection and try again.'),
                ],)),
                actions: <Widget>[
                  TextButton(
                    child: Center(child: Text('Ok', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
          ),
          );
            }
            return loadingScreen(context,'Loading...');
          }

        )
      ),

      
      
    );
  }
}