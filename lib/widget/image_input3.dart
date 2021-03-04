import 'package:flutter/material.dart';
import 'dart:io';

import 'signup_modal3.dart';

class ImageInput3 extends StatefulWidget {
  final Function onSelectImage;

  ImageInput3(this.onSelectImage);
  @override
  _ImageInput3State createState() => _ImageInput3State();
}

class _ImageInput3State extends State<ImageInput3> {
  int selectedRadioTile;
   File _pickedImage;

   void _selectImage(File pickedImage) {
     setState(() {
        _pickedImage = pickedImage;
     });
   

  }
   
  @override
  void initState() {
    selectedRadioTile = 0;
    super.initState();
  }

  _setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      //selected = true;
    });
  }

 // bool activeRadioTile(bool val) {
  //  setState(() {
  //    val = !val;
  //  });
  //}

   void _startAddPhoto(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: SignUpModal3(_selectImage),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: 
      Column(
        children: <Widget>[
          RadioListTile(
            value: 1,
            groupValue: 
            selectedRadioTile,
            title: Text('Barangay Clearance'),
            onChanged: (val){
               _setSelectedRadioTile(val);

            },
            activeColor: Theme.of(context).primaryColor,
            secondary: IconButton(onPressed: (){}, icon: Icon(Icons.info),
            color: Color.fromRGBO(62, 135, 148, 1),
          ),
         // selected: true,
          ),
         RadioListTile(
        value: 2,
        groupValue: 
        selectedRadioTile,
        title: Text('Police Clearance'),
        onChanged: (val){
           _setSelectedRadioTile(val);

        },
        activeColor: Theme.of(context).primaryColor,
        secondary: IconButton(onPressed: (){}, icon: Icon(Icons.info),
        color: Color.fromRGBO(62, 135, 148, 1),
      ),
      // selected: false,
      ),
       RadioListTile(
        value: 3,
        groupValue: 
        selectedRadioTile,
        title: Text('NBI Clearance'),
        onChanged: (val){
           _setSelectedRadioTile(val);

        },
        activeColor: Theme.of(context).primaryColor,
        secondary: IconButton(onPressed: (){}, icon: Icon(Icons.info),
        color: Color.fromRGBO(62, 135, 148, 1),
      ),
      // selected: false,
      ),
      SizedBox(height: 5),
      GestureDetector(
        onTap: () => _startAddPhoto(context),
              child: Container(
                alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.20,
          height: MediaQuery.of(context).size.height * 0.10,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).primaryColor),
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
        ],
      ),
      
    );
  }
}