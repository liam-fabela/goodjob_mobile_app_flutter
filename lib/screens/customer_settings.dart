import 'package:flutter/material.dart';

import '../styles/style.dart';
import '../helper/firebase_user.dart';
import '../widget/customer_edit.dart';

class CustomerSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     onItemPressed(BuildContext context, int index){
      switch(index){
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CustomerEdit(UserProfile.dbUser)));
          break;
        default:

      }
    }
    return Scaffold(
      appBar: appBarSign(context, 'Settings'),
      body:Container(
        padding: EdgeInsets.all(15),
        child: ListView.separated(
           itemBuilder: (context, index){
            Icon icon;
            Text text;
             switch(index) {
              case 0:
              icon = Icon(Icons.edit);
              text = Text('Edit Profile');
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
          itemCount: 1,
        ),
      ),
      
    );
  }
}