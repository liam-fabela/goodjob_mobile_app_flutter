import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String img;

  CategoryItem(this.title, this.img);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
         // margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                     Radius.circular(15),
                     
                    ),
                    child: Image.asset(
                      img,
                     
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    //right: 10,
                    child: Container(
                     // width: MediaQuery.of(context).size.width * 0.6,
                      color: Color.fromRGBO(29, 171, 145, 0.5),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )));
  }
}