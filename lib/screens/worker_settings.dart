import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../helper/firebase_user.dart';
import 'worker_report.dart';
import 'worker_edit.dart';
import 'worker_payout.dart';
import 'worker_upgrade.dart';

class WorkerSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     onItemPressed(BuildContext context, int index){
      switch(index){
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> WorkerEdit(UserProfile.dbUser)));
          break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> WorkerPayout(UserProfile.dbUser)));
          break;
        case 2:
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> WorkerUpgrade(UserProfile.dbUser)));
          break;
        case 3:
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> WorkerReport(UserProfile.dbUser)));
          break;
        default:

      }
    }


    return Scaffold(
      appBar: appBarSign(context, 'Settings'),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
          itemBuilder: (context, index){
            Icon icon;
            Text text;

            switch(index) {
              case 0:
              icon = Icon(Icons.edit);
              text = Text('Edit Profile');
                break;
              case 1:
              icon = Icon(Icons.credit_card);
              text = Text('Request Payout');
               break;
               case 2:
              icon = Icon(Icons.upgrade);
              text = Text('Upgrade Credibility level');
               break;
               case 3:
              icon = Icon(Icons.report);
              text = Text('Report');
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
          itemCount: 4,
        ),
        ),
      
    );
  }
}