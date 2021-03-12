import 'package:flutter/material.dart';
import 'dart:io';

import 'cusBack_signup_modal.dart';
import 'cusFront_signup_modal.dart';


class CustomerImageInput2 extends StatefulWidget {

  final Function onSelectImage1;
  final Function onSelectImage2;

  CustomerImageInput2(this.onSelectImage1, this.onSelectImage2);
  @override
  _CustomerImageInput2State createState() => _CustomerImageInput2State();
}

class _CustomerImageInput2State extends State<CustomerImageInput2> {
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
          child: choice == 1 ? CustomerFrontSignUpModal(_selectImage) : CustomerBackSignUpModal(_selectImage2),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}