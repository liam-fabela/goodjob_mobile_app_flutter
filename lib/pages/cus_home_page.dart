import 'package:flutter/material.dart';

import '../styles/style.dart';

class CustomerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
     margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.white70,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Search Worker...', style: TextStyle(color: Colors.grey, fontFamily: 'Raleway' ),),
                    ),
                    Icon(Icons.search, color: Color.fromRGBO(62, 135, 148, 1),),
                  ],
                ),
              ),
            ),
          ),
           SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
           Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
               padding: EdgeInsets.fromLTRB(
                   20.0, 10.0, 20.0, 20.0),
                decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10),
              ),
             child: TextFormField(
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                decoration:
                  textFieldInputDecoration('Create a Job Posting...'),
                ),
           ),

          
        ],
      ),
    );
  }
}
