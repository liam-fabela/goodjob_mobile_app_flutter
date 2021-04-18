import 'package:flutter/material.dart';

import '../helper/shared_preferences.dart';

class WorkerProfileGrid extends StatelessWidget {
  final int id;
  final String title;
  final IconData icon;
  WorkerProfileGrid(this.id, this.title, this.icon);

  Future<void> _logOut(BuildContext context) async {
   // var data = SharedPrefUtils.getPref('user');
    showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Log out.', style: TextStyle(color: Colors.black),),
                content: SingleChildScrollView(child:ListBody(children: [
                   Text('Are you sure you want to logout?.'),
                ],)),
                actions: <Widget>[
                 
                  TextButton(
                    child: Center(child: Text('Yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
                    onPressed: () {
                      SharedPrefUtils.removePref();
                       Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                      
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
   

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: (){
            if(id==4){
              _logOut(context);
            }
          },
          child: Container(

         color: Color.fromRGBO(75, 210, 178, 1),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Icon(icon, size:40, color: Color.fromRGBO(62, 135, 148, 1),),),
              Text(title, style: TextStyle(fontFamily: 'Raleway', fontSize: 14, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}