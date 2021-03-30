import 'package:flutter/material.dart';

Widget listTileInfo2(BuildContext context, String image, String title, String text) {
  return ListTile(
    leading: Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width * 0.10,
      child: Image.network(
        image,
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'Raleway',
      ),
    ),
    subtitle: Container(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: <Widget>[
          Text(text),
        ],
      ),
    ),
  );
}
