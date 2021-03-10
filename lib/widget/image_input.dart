import 'package:flutter/material.dart';
import 'dart:io';


import 'signup_modal.dart';




class ImageInput1 extends StatefulWidget {

  final Function onSelectImage;


  ImageInput1(this.onSelectImage);
  @override
  _ImageInput1State createState() => _ImageInput1State();
}

class _ImageInput1State extends State<ImageInput1> {
  
  File _pickedImage;
  //File _storedImage;
  String filePhoto;

  

   void _selectImage(File pickedImage, String fileName) {
     filePhoto = fileName;
     setState(() {
        _pickedImage = pickedImage;
     });
     widget.onSelectImage(_pickedImage, filePhoto);

   

  }

  void _startAddPhoto(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: SignUpModal(_selectImage),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
        Column(
          children: <Widget>[
            GestureDetector(
               onTap: () => _startAddPhoto(context),
                child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 1, color: Theme.of(context).primaryColor),
                ),
                child:  _pickedImage != null
                ? Image.file(
                    _pickedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                :Icon(Icons.add),
              ),
            ),
         // SizedBox(height: 5),
          Container(
          padding: EdgeInsets.all(20),

          child: FlatButton.icon(
            icon: Icon(Icons.person_outline),
            label: Text('Front view photo.'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {},//_takePicture,
          ),
        ),
      ],
    );
  }
}
