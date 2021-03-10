import 'package:flutter/material.dart';
import 'dart:io';


import '../widget/signup_front_modal.dart';
import '../widget/signup_back_modal.dart';


class ImageInput2 extends StatefulWidget {

  final Function onSelectImage1;
  final Function onSelectImage2;

  ImageInput2(this.onSelectImage1, this.onSelectImage2);
  @override
  _ImageInput2State createState() => _ImageInput2State();
}

class _ImageInput2State extends State<ImageInput2> {
  File _pickedImage1;
  File _pickedImage2;
  String filePhoto1;
  String filePhoto2;


  void _selectImage(File firstPickedImage, String fileName) {
    filePhoto1 = fileName;
     setState(() {
        _pickedImage1 = firstPickedImage;
     });
     widget.onSelectImage1(_pickedImage1, filePhoto1);
  }

  void _selectImage2( File secondPickedImage, String fileName2) {
    filePhoto2 = fileName2;
     setState(() {
        _pickedImage2 = secondPickedImage;
     });
     widget.onSelectImage2(_pickedImage2,filePhoto2);
  }

  void _startAddPhoto(BuildContext ctx, int choice) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: choice == 1 ? SignUpFrontModal(_selectImage) : SignUpBackModal(_selectImage2),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        GestureDetector(
          onTap: () => _startAddPhoto(context, 1),
             child: Container(
             //padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Theme.of(context).primaryColor),
            ),
            child:  _pickedImage1 != null
                ? Image.file(
                    _pickedImage1,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Icon(Icons.add),
          ),
        ),
        Container(
          // width: MediaQuery.of(context).size.width * 0.20,
          padding: EdgeInsets.all(5),
          child: FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              'Front of ID.',
             
             
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed:  (){},
          ),
        ),
        ],
        ),
        SizedBox(height: 10),
        Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         GestureDetector(
             onTap: () => _startAddPhoto(context, 2),
                    child: Container(
             // padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Theme.of(context).primaryColor),
            ),
            child:  _pickedImage2 != null
                ? Image.file(
                    _pickedImage2,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                :Icon(Icons.add)
        ),
         ),
         Container(
         //  width: MediaQuery.of(context).size.width * 0.20,
          //height: MediaQuery.of(context).size.height * 0.15,
          //padding: EdgeInsets.all(3),
          child: FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              'Back of ID.',
             
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: (){},
          ),
        ),
        ],
        ),
      ],
    );
  }
}
