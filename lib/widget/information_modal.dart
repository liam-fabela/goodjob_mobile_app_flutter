import 'package:flutter/material.dart';

import 'list_tile.dart';

class InformationModal extends StatefulWidget {
  final String image;
  final String title;
  final String text;

  InformationModal(this.image, this.title, this.text);
  @override
  _InformationModalState createState() => _InformationModalState();
}

class _InformationModalState extends State<InformationModal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            child: listTileInfo(context,widget.image, widget.title, widget.text),
         
        
      ),
    );
  }
}