import 'package:flutter/material.dart';


import '../helper/shared_preferences.dart';
import '../helper/authenticate.dart';


class CustomerGridItem extends StatelessWidget {

  final int id;
  final String title;
  final IconData icon;

  CustomerGridItem(this.id, this.title, this.icon);

  Future<void> _logOut(BuildContext context) async {
   // var data = SharedPrefUtils.getPref('user');
    SharedPrefUtils.removePref('user');
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Authenticate()));

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
              Expanded(child: Icon(icon, size:50, color: Color.fromRGBO(62, 135, 148, 1),),),
              Text(title, style: TextStyle(fontFamily: 'Raleway', fontSize: 14, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
