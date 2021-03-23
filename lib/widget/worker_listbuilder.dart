import 'package:flutter/material.dart';

class ProfileListBuilder extends StatelessWidget {

  final List data = ["Schedule Calendar","Reviews"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

          onTap: (){},
          child: Container(
        child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width * 0.10,
      child: Icon(Icons.lens_outlined, color: Color.fromRGBO(62, 135, 148, 1), ),
      ),
  
            title: Text(data[index], style: TextStyle(
                    color: Color.fromRGBO(62, 135, 148, 1),
                    fontSize: 12,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
            ), ),
            trailing: Icon(Icons.navigate_next_sharp),
          );
        },
        ),
        
      ),
    );
  }
}