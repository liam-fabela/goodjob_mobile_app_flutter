import 'package:flutter/material.dart';

import '../styles/style.dart';
import 'accepted_works.dart';
import 'finished_works.dart';
import '../helper/firebase_user.dart';



class WorkerWorks extends StatefulWidget {
  @override
  _WorkerWorksState createState() => _WorkerWorksState();
}

class _WorkerWorksState extends State<WorkerWorks> {

  @override
  Widget build(BuildContext context) {

    onItemPressed(BuildContext context, int index){
      switch(index){
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> AcceptedWorksPage(UserProfile.dbUser)));
          break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> FinishedWorksPage(UserProfile.dbUser)));
          break;

      }
    }

    return Scaffold(
      appBar: appBarSign(context, 'My Works'),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
          itemBuilder: (context, index){
            Icon icon;
            Text text;

            switch(index) {
              case 0:
              icon = Icon(Icons.check_circle_outline);
              text = Text('Accepted Works');
                break;
              case 1:
              icon = Icon(Icons.check_circle);
              text = Text('Finished Works');
               break;
              default:
            }
            return InkWell(
              onTap: (){
                onItemPressed(context, index);
              },
              child: ListTile(
                title: text,
                leading: icon,
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(color: Colors.green),
          itemCount: 2,
        ),
        ),
     
      
    );
  }
}